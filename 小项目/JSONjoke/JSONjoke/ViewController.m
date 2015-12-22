//
//  ViewController.m
//  JSONjoke
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "joke.h"
@interface ViewController ()
{
    NSString *_path;
    NSMutableArray *_jokeArray;
    NSUInteger index;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *click_countLable;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    index = 0;
    _path = @"/Users/apple/Desktop/joke.plist";
    _jokeArray = [NSMutableArray array];
//    if (![NSKeyedUnarchiver unarchiveObjectWithFile:_path]) {
//        
//        _jokeArray = [NSMutableArray array];
//        [NSKeyedArchiver archiveRootObject:_jokeArray toFile:_path];
//    }
//    _jokeArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    [self loadJoke];
    [self displayWithStory:[_jokeArray firstObject]];
}
- (IBAction)nextButtonCliked:(id)sender{
    if (index == [_jokeArray count] - 1) {
        index = 0;
    }else
    {
        index++;
    }
    joke * Joke = [_jokeArray objectAtIndex:index];
    [self displayWithStory:Joke];
}
- (IBAction)preButtonCliked:(id)sender{
    if (index == 0) {
        index = [_jokeArray count] - 1;
    }else
    {
        index--;
    }
    joke * Joke = [_jokeArray objectAtIndex:index];
    [self displayWithStory:Joke];
}

- (void)parseJSONData:(NSData *)data{
    
    NSDictionary *alldict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *items = alldict[@"items"];
    for (NSDictionary *dict in items) {
       NSString *contents = dict[@"content"];
       NSString *click_count = dict[@"click_count"];
       NSLog(@"%@",click_count);
        NSDictionary *authDict =dict[@"author"];
        NSString *nickName = authDict[@"nickname"];
        NSString *icon = authDict[@"iocn"];
        
        joke *Joke = [joke new];
        Joke.nickname = nickName;
        Joke.click_count = click_count;
        Joke.jokeContent = contents;
        Joke.iconPath = icon;
        
        
        
        [_jokeArray addObject:Joke];
    }
   // [NSKeyedArchiver archiveRootObject:_jokeArray toFile:_path];
    NSLog(@"_jokeArray%@",_jokeArray);
}
- (void)loadJoke{
    
    NSString *urlString = @"http://appd2.lengxiaohua.cn:8888/?apptype=1&srv=1201&cid=9986657&uid=0&tms=20150507212029&sig=AD0C4CF781F479CF&wssig=E24B51F4A628313C&os_type=1&detail=1&pg_id=30&pg_size=50&pg_up=0&type=10";
    //从网络请求数据
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    [self parseJSONData:data];
    //[data writeToFile:@"/Users/apple/Desktop/data.plist" atomically:YES];
}

- (void)displayWithStory:(joke *)Joke
{
    _nickNameLable.text = [NSString stringWithFormat:@"用户名：%@",Joke.nickname];
    _contentTextView.text = Joke.jokeContent;
    _click_countLable.text = [NSString stringWithFormat:@"点 赞：%@ ",Joke.click_count];
   // [_imageView setImage:[UIImage imageNamed:]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
