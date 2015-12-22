//
//  ViewController.m
//  KaraokeLyricsParser
//
//  Created by Cheetah on 15/8/27.
//  Copyright (c) 2015年 diveinedu. All rights reserved.
//

#import "ViewController.h"

@interface SingleLineLyric : NSObject <NSCopying>
@property (nonatomic,assign) NSUInteger startTime;
@property (nonatomic,strong) NSString *lyricText;
@end
@implementation SingleLineLyric
- (id)copyWithZone:(NSZone *)zone
{
    SingleLineLyric *newObj = [[self class]allocWithZone:zone];
    newObj.startTime = self.startTime;
    newObj.lyricText = self.lyricText;
    return newObj;
}


- (NSComparisonResult)compare:(SingleLineLyric *)other
{
    if(self.startTime < other.startTime){
        return  NSOrderedAscending;
    }else if(self.startTime > other.startTime){
        return NSOrderedDescending;
    }else{
        return NSOrderedSame;
    }
}

@end

@interface ViewController ()
{
//    歌词文件路径
    NSString *_lyricsFilePath;
//    每行歌词的数组
    NSMutableArray *_lyricsLinesArray;
//    定时器对象
    NSTimer *_timer;
//    定时器累计时
    NSUInteger  _timePasted;
}
@property (weak, nonatomic) IBOutlet UILabel *lyricLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _lyricsLinesArray = [NSMutableArray array];
    _lyricsFilePath = @"/Users/apple/Desktop/tinghai.lrc";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)letKaraokeButtonClicked:(id)sender {
    //必须，必须，必须记得先使得旧的定时器对象失效。
    [_timer invalidate];
    //读出歌词文件数据，调用解析方法去解析歌词数据
    NSData *data = [NSData dataWithContentsOfFile:_lyricsFilePath];
    [self parseWholeLyricsWithData:data];
    
    _timePasted = 0;
    //歌词解析完后创建并开始定时器，每隔0.1s触发一次  更新歌词到界面  方法
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(更新歌词到界面) userInfo:nil repeats:YES];
    
}

//中文方法名，不要再说看不懂英文😁
- (void)更新歌词到界面
{
    //定时器触发的时间不是特别精确，但是我们这里简单处理，每0.1s触发一次,累加时间
    _timePasted += 0.1*1000;
    //用谓词来获取当前的时刻以后的歌词，然后取结果数组的第一个，就是当前正在唱的歌词对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startTime <= %lu", _timePasted];
    NSArray *resultArray = [_lyricsLinesArray filteredArrayUsingPredicate:predicate];
    SingleLineLyric *currentLyricObj = [resultArray lastObject];
    //把对象中的歌词文本显示到界面
    _lyricLabel.text = currentLyricObj.lyricText;
}



//此方法专门处理歌词文件全部的数据
- (void)parseWholeLyricsWithData:(NSData *)data
{
    //先清除歌词数组
    [_lyricsLinesArray removeAllObjects];
    //把歌词文件数据转换为字符串
    NSString *wholeLyricsString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //按行分割成数组，每一行字符串为一个元素
    NSArray *linesArray = [wholeLyricsString componentsSeparatedByString:@"\n"];
    //遍历解析处理每一行歌词
    for (NSString *line in linesArray) {
        //去除首尾空白和全部转小写
        NSString *trimmedLine = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        trimmedLine = [line lowercaseString];
        //字符串如果长度小于5，无效，忽略跳过
        if (trimmedLine.length<=5) continue;
        //我们这暂不解析歌名，艺人，专辑以及偏移时间这些信息，判断并略过
        if ([trimmedLine hasPrefix:@"[ti:"] || [trimmedLine hasPrefix:@"[ar:"]
            ||[trimmedLine hasPrefix:@"[al:"] || [trimmedLine hasPrefix:@"[offset:"]) {
            //我们这里直接忽略掉非歌词的行
            continue;
        }
        //到这了就是有效的单行带有时间标签与歌词的字符串了
        [self parseOneLineLyricWithString:trimmedLine];
    }
    //解析完所有歌词之后，对歌词数组进行排序，根据时间值排序，自定义类实现了compare:方法。
    [_lyricsLinesArray sortUsingSelector:@selector(compare:)];

}

//此方法专门解析处理歌词文件中单行字符串
- (void)parseOneLineLyricWithString:(NSString *)line
{
    //先判断是否以[开始，否则忽略不处理
    if (![line hasPrefix:@"["]) return;
    //从字符串末尾开始反向查找]标记的位置
    NSUInteger timeStampEndPos = [line rangeOfString:@"]" options:NSBackwardsSearch].location;
    //再判断]结束标记的位置,过短的也忽略，因为无效
    if (timeStampEndPos < 9) return;
    //分别取出左边时间戳字符串和右边的歌词内容到2个字符串对象
    NSString *timeStampsStr = [line substringToIndex:(timeStampEndPos+1)];
    NSString *lyricLineStr = [line substringFromIndex:(timeStampEndPos+1)];
    
    //上面时间戳字符串可能一行有多个时间,如[xx:yy.zzz][xx:yy.zzz]
    //下面用]字符去分割它
    NSArray *timeStampArray = [timeStampsStr componentsSeparatedByString:@"]"];
    for (NSString *singleTimeStamp in timeStampArray) {
        //[xx:yy.zzz
        if (![singleTimeStamp hasPrefix:@"["]) continue;
        //删除第一个字符[变成xx:yy.zzz
        NSString *timeStampStr = [singleTimeStamp substringFromIndex:1];
        NSUInteger startTime = [self  milliSecondsFromTimeStampString:timeStampStr];
        //创建对象，保存时间值和歌词字符串
        SingleLineLyric *singleLineObj = [SingleLineLyric new];
        singleLineObj.startTime = startTime;
        singleLineObj.lyricText = lyricLineStr;
        //加入数组
        [_lyricsLinesArray addObject:singleLineObj];
    }
}

//此方法专门把如00:01.25的时间格式字符串转换为单位为毫秒的整数值1250
- (NSUInteger)milliSecondsFromTimeStampString:(NSString *)timeStampStr
{
    //OC字符串转C字符串
    const char *str = [timeStampStr cStringUsingEncoding:NSUTF8StringEncoding];
    int min,sec,per_sec;
    //按格式解析为三个整数值
    sscanf(str,"%d:%d.%d",&min,&sec,&per_sec);
    NSUInteger milliSeconds = min*60*1000 + sec*1000 + per_sec*10;
    return milliSeconds;
}

@end

















