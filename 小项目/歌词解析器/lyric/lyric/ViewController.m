//
//  ViewController.m
//  lyric
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "modelLyric.h"

@interface ViewController ()
{
    NSString *_lyricPath;
    NSMutableArray *_singLyricArray;
    NSTimer *_timer;
    NSInteger _time;
}
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   _lyricPath = @"/Users/apple/Desktop/遥远的她";
    _singLyricArray  = [NSMutableArray array];
}

- (IBAction)beginButtonCliked:(id)sender {
    
    [_timer invalidate];
    NSData *data = [NSData dataWithContentsOfFile:_lyricPath];
    [self getSinglyric:data];
    _time = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLyricOnView) userInfo:nil repeats:YES];
}
//把数据转为字符串，并且把每一行作为一个对象存在字符串中。
- (void)getSinglyric:(NSData *)data
{
    NSString *allLyricString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [allLyricString componentsSeparatedByString:@"\n"];
    for (NSString *str in array) {
        
        if (![str hasPrefix:@"[0"]) {
            
            continue;
        }
        [self parseOneLineLyricWithString:str];
    }
}
//对单行单词的操作
-(void)parseOneLineLyricWithString:(NSString *)str
{
    NSArray *singArray = [str componentsSeparatedByString:@"] "];
    NSString *lyricString = [singArray lastObject];
    NSString *startString = [singArray firstObject];
    NSInteger startTime = [self milliSecondsFromTimeStampString:startString];
    modelLyric *modellyric = [modelLyric new];
    modellyric.startTime = startTime;
    modellyric.lyric = lyricString;
    [_singLyricArray addObject:modellyric];
}


-(NSInteger)milliSecondsFromTimeStampString:(NSString *)timeStampStr
{
    //oc字符串转为c字符串
    const char *str=[timeStampStr cStringUsingEncoding:NSUTF8StringEncoding];
    int min,sec,per_sec;
    //把00:00.00形式的字符串转换为后面的形式
    sscanf(str, "[%d:%d.%d",&min,&sec,&per_sec);
    NSUInteger milliSeconds=min*60*1000+sec*1000+per_sec*10;
    return milliSeconds;
}

-(void)updateLyricOnView
{
    _time+=0.1*1000;
    //把开始时间小于_time的modelLyric对象取出来然后取出来最后一个。
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"startTime <= %lu",_time];
    NSArray * resultArray=[_singLyricArray filteredArrayUsingPredicate:predicate];
    modelLyric * currentLyricobj=(resultArray && resultArray.count>0)?resultArray.lastObject:nil;
    _showLabel.text = currentLyricobj.lyric;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
