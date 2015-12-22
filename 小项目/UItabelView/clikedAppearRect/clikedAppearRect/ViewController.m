//
//  ViewController.m
//  clikedAppearRect
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_array;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    _tableView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    for (int i = 0; i < 100; i++) {
        
        [_array addObject:@(1)];
    }   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%lu",(unsigned long)[_array count]);
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(200, 5, 100, 25)];
        label.tag = 1003;
        [cell.contentView addSubview:label];
    }
    
    UILabel *tempLabel = (UILabel *)[cell.contentView viewWithTag:1003];
    
    if ([_array[indexPath.row] isEqual:@(1)]) {
        
        tempLabel.backgroundColor = [UIColor whiteColor];
    }else{
        
        tempLabel.backgroundColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *num = _array[indexPath.row];
    if (num.integerValue == 0) {
        
        _array[indexPath.row] = @(1);
    }else{
        
        _array[indexPath.row] = @(0);
    }
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
