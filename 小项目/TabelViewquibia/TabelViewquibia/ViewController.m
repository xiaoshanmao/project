//
//  ViewController.m
//  TabelViewquibia
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "Hpple/TFHpple.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "CustomTableViewCell.h"
#import "joke.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_jokeArray ;
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadJokeData];
    _jokeArray = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (void)loadJokeData{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qiushibaike.com/text"]];
  
    [req setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
  
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:req success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [self parseHTMLData:responseObject];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
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
       // NSLog(@"%@",nickName);
        jok.rotes = rotes;
        NSLog(@"%@",rotes);
        jok.content = content;
        jok.comment = comment;
        
        [_jokeArray addObject:jok];
    }
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_jokeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    joke *jok = [joke new];
    jok = _jokeArray[indexPath.row];
    
    cell.TextNickName = jok.rotes;
    cell.Text1 = jok.comment;
    cell.limage = jok.aratorStr;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
