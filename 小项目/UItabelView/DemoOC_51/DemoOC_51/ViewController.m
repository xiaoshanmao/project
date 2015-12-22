//
//  ViewController.m
//  DemoOC_51
//
//  Created by frankfan on 15/11/16.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataList;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    
    _dataList = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        
        [_dataList addObject:@(1)];
    }
    

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if([_dataList[indexPath.row]isKindOfClass:[NSString class]]){
    
        cell.backgroundColor = [UIColor grayColor];
    }else{
    
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if([_dataList[indexPath.row]isKindOfClass:[NSString class]]){
    
        return;
    }
    
    if([_dataList[indexPath.row]isEqual:@1]){//展开

        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (int i = (int)indexPath.row + 1; i<indexPath.row+1+3; i++) {
            
            NSIndexPath *lindexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            [indexPaths addObject:lindexPath];
            
            [_dataList insertObject:@"placeHodler" atIndex:i];
        }
        
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        
        _dataList[indexPath.row] = @0;

    }else{//收起
    
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (int i = (int)indexPath.row + 1; i<indexPath.row+1+3; i++) {
            
#warning 注意变量命名，不要覆盖全局
            NSIndexPath *lindexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            [indexPaths addObject:lindexPath];
            
            [_dataList removeObjectAtIndex:indexPath.row+1];
        }
        
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
        
        _dataList[indexPath.row] = @1;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
