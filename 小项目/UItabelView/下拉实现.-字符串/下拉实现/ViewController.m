//
//  ViewController.m
//  下拉实现
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_array;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        
        [_array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_array[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    UITableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath1];
    UITableViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    if (([cell.textLabel.text isEqualToString:@"0"]||[cell.textLabel.text isEqualToString:@"1"]||[cell.textLabel.text isEqualToString:@"2"]) && ![nextCell.textLabel.text containsString:@"-"]) {
        
        for (int i = 0; i<3; i++) {
            
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:(indexPath.row + i +1)inSection:0];
            
            [indexPaths addObject:indexPath1];
            [_array insertObject:[NSString stringWithFormat:@"%@-%d", cell.textLabel.text,i] atIndex:indexPath.row+i+1];
        }
         [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
        
    }else if (([cell.textLabel.text isEqualToString:@"0"]||[cell.textLabel.text isEqualToString:@"1"]||[cell.textLabel.text isEqualToString:@"2"]) && [nextCell.textLabel.text containsString:@"-"]){
        
        for (int i = 0; i < 3; i++) {
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:(indexPath.row + i + 1) inSection:0];
            [indexPaths addObject:indexpath];
            [_array removeObjectAtIndex:indexPath.row + 1];
        }
        NSLog(@"%@",_array);
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
