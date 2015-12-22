//
//  ViewController.m
//  任务一
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
    UILabel *_label;
    UITextField *_textfield;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = [NSMutableArray array];
    [self creatTableView];
    [self creatLabel];
    [self creatButton];
    [self creatTextField];
}


- (void)creatTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
   //_tableView.sectionHeaderHeight = 0.01;
    

    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@80);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.view);
    }];
}


- (void)creatTextField{
    
    _textfield = [[UITextField alloc] init];
    _textfield.font = [UIFont systemFontOfSize:14];
    _textfield.backgroundColor = [UIColor grayColor];
    //后面出现一个X
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_textfield];
    
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label.mas_bottom);
        make.left.equalTo(@50);
        make.height.equalTo(@30);
        make.width.equalTo(@300);
    }];
    
}


- (void)creatLabel{
    
    _label = [[UILabel alloc]init];
    _label.text = @"任务列表";
    _label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.left.equalTo(@150);
        make.height.equalTo(@50);
        make.width.equalTo(@300);
    }];
}


- (void)creatButton{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label);
        make.left.equalTo(_label.mas_left).offset(150);
        make.height.equalTo(_label);
        make.width.equalTo(@50);
    }];
    
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    //normal状态下的文字颜色
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    //高亮状态下的文字颜色
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor orangeColor];
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blueColor];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0.01;
    }
    return 100;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_array count];
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 100, 30)];
        label.tag = 1002;
        [cell.contentView addSubview:label];
    }
    
    if (indexPath.section == 0) {
        
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:1002];
        label.text = [NSString stringWithFormat:@"%@",_array[indexPath.row]];
        
        [cell.contentView addSubview:label];
    }
   
    
    return cell;
}

//button被点击回调
- (void)buttonClicked:(UIButton *)sender{
    
    [_array addObject:_textfield.text];
    [_tableView reloadData];
     [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
