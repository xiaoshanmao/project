//
//  ViewController.m
//  quibai
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "joke.h"
#import "Hpple/TFHpple.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "animal.h"
#import "getNum.h"

@interface ViewController ()
{
    NSMutableArray *_jokeArray;
    NSUInteger index;
}

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *aratarImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    animal *anl = [animal new];
//    anl.delegate = self;
    [anl launch];
    
//    [anl numFromBlc:^(int a) {
//        NSLog(@"a:%d",a);
//    }];
    
    anl.block = ^(int a){
        
        NSLog(@"%d",a);
    };
#if 0
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ttt:) name:@"notikey" object:nil];
    [anl launch];
    
    
    _jokeArray = [NSMutableArray array];
    [self loadJokeData];
    index = 0;
#endif
}

- (void)getNum:(int)a
{
    NSLog(@"%d",a);
}

- (void)ttt:(NSNotification *)nit
{
    NSNumber *value = [nit object];
    NSLog(@"%d",value.intValue);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notikey" object:nil];
}


- (void)loadJokeData{
    
    //创建一个HTTP请求操作管理器。
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //数据过来要序列化，
    //由于默认的管理器对http响应的序列化器属性是AFJSONResponseSerializer
    //我们现在是要取html数据，所有设置为普通的AFCompoundResponseSerializer，不然会失败。
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
  
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qiushibaike.com/text"]];
    //修改http请求头域，伪装pc浏览器。在不同的设备都能使用。
    [req setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    
    //创建一个请求操作
    //不会立刻取得数据，当block回调才会取得数据。
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:req success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //交给解析html的方法处理。
        //blc(responseObject);
        [self parseHTMLData:responseObject];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    //开始这个请求操作。
    [operation start];
}

- (void)parseHTMLData:(NSData *)data{
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:data encoding:@"utf-8"];
    NSArray *eles = [hpple searchWithXPathQuery:@"//div[@class='article block untagged mb15']"];
    for (TFHppleElement *ele in eles) {
        
        NSArray *tempeles = [ele searchWithXPathQuery:@"//div[@class='content']"];
        TFHppleElement *lele = [tempeles firstObject];
        NSString *content =[lele content];
        
        NSArray *tempeles1 = [ele searchWithXPathQuery:@"//h2"];
        TFHppleElement *lele1 = [tempeles1 firstObject];
        NSString *rotes = [lele1 content];
       
        NSArray *tempeles2 = [ele searchWithXPathQuery:@"//i[@class='number']"];
        TFHppleElement *lele2 = [tempeles2 firstObject];
        NSString *nickName = [lele2 content];
        
        NSArray *tempeles3 = [ele searchWithXPathQuery:@"//@src"];
        TFHppleElement *lele3 = [tempeles3 firstObject];
        NSString *arator = [lele3 content];
        
        NSArray *tempeles4 = [ele searchWithXPathQuery:@"//i[@class='number']"];
        TFHppleElement *lele4 = [tempeles4 lastObject];
        NSString *comment = [lele4 content];
        
        joke *jok = [joke new];
        jok.nickName = nickName;
        jok.aratorStr = arator;
        jok.rotes = rotes;
        jok.content = content;
        jok.comment = comment;
        
        [_jokeArray addObject:jok];
        //由于取得数据是异步的所有直接在viewDidLoad，调用这个方法让他显示时并没有数据。
        [self displayWithJoke:[_jokeArray firstObject]];

    }
}


- (IBAction)preButtonCliked:(id)sender {
    
    if (index ==0) {
        
        index = [_jokeArray count] - 1;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }else{
        
        index--;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }
    
}
- (IBAction)nextButtonCliked:(UIButton *)sender {
    
    if (index == [_jokeArray count] - 1) {
        
        index = 0;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }else{
        
        index++;
        joke *jok = [_jokeArray objectAtIndex:index];
        [self displayWithJoke:jok];
    }
}


- (void)displayWithJoke:(joke *)jok{

    _nickNameLabel.text = jok.rotes;
    _contentTextView.text = jok.content;
    _rotesLabel.text = [NSString stringWithFormat:@"%@好笑",jok.nickName];
    _commentLabel.text = [NSString stringWithFormat:@"%@评论",jok.comment];
    [_aratarImageView setImageWithURL:[NSURL URLWithString:jok.aratorStr]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
