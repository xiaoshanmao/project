//
//  ViewController.m
//  SQL--city
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "FMDatabase.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    FMDatabase *_database;
    UITableView *_tableView;
    NSMutableArray *_letters;
    NSMutableArray *_citys;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _citys = [NSMutableArray array];
    NSString *CityStr = @"/Users/apple/Desktop/citysNew.sqlite";
    _database = [FMDatabase databaseWithPath:CityStr];
    if (![_database open]) {
        
        NSLog(@"打开失败");
        return;
    }
    
    if ([_database executeUpdate:@"create table if not exists citysNew (cityName text,fristLetter text)"]) {
        
        NSLog(@"创建成功");
    }
    
    NSString *findLetter = @"select distinct fristLetter from citysNew order by fristLetter asc";
    FMResultSet *rs = [_database executeQuery:findLetter];
    _letters = [NSMutableArray array];
    while ([rs next]) {
        
        [_letters addObject:[rs stringForColumn:@"fristLetter"]];
    }
    for (NSString *tempFirstLetter in _letters) {
        
        FMResultSet *tempResult = [_database executeQueryWithFormat:@"select cityName from citysNew where fristLetter = %@",tempFirstLetter];
        NSMutableArray *citys = [NSMutableArray array];
        while ([tempResult next]) {
            
            NSString *city = [tempResult stringForColumn:@"cityName"];
            [citys addObject:city];
        }
        [_citys addObject:citys];
    }
    [_database close];
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style: UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.sectionHeaderHeight = 50;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
     return _letters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *tempArray = _citys[section];
    return tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *array = _citys[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    return cell;
    
}
- (void)executeUpdate:(NSString *)str{
    
    NSString *str1 = [self fristLetterWithCity:str];
    NSString *insertSQL = @"insert into citysNew('cityName','fristLetter') values (%@,%@)";
    if ([_database executeUpdateWithFormat:insertSQL ,str,str1]) {
        
        NSLog(@"插入成功");
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 0)];
    headerView.backgroundColor = [UIColor blackColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 50)];
    label.textColor = [UIColor whiteColor];
    [headerView addSubview:label];
    
    label.text = _letters[section];
    
    return headerView;
}

//汉字转拼音
- (NSString *)fristLetterWithCity:(NSString *)str{

    CFStringRef strRef = (__bridge CFStringRef)str;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, strRef);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *resultString = (__bridge NSString *)string;
    
    NSString *finalString = [resultString substringToIndex:1];
    
    NSString *tempFristS = [str substringWithRange:NSMakeRange(0, 1)];
    if ([tempFristS isEqualToString:@"长"]) {
        
        return @"C";
    }
    //转大写
    return [finalString uppercaseString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
