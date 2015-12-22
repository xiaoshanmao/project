//
//  ViewController.m
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "SeconderViewController.h"
#import "TaskR.h"
#import "MessageMoel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tabelView;
    NSMutableArray *_taskarray;//存储单例里的数组，返回cell的个数和样式
    NSString *_path;//保存的地址路径
    MessageMoel *mol;
    NSIndexPath *indexpath;//用于当点击一个cell时调用代理方法传indexpath到第二个页面
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _path = @"/Users/apple/Desktop/task.plist";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(self.view.frame.size.width - 60, 20, 50, 30);
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width,  self.view.frame.size.height -50 ) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
}

#pragma mark - 添加的button点击
- (void)buttonDidCliked:(UIButton *)sender{
    
    SeconderViewController *secV = [SeconderViewController new];
    [self presentViewController:secV animated:YES completion:^{
        
    }];
}

#pragma mark - 返回cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_taskarray count];
}

#pragma mark - 返回cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if(!cell){
           
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            UILabel *label = [UILabel new];
            label.tag = 1001;
            [cell.contentView addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
    
    UILabel *tempLabel = (UILabel *)[cell.contentView viewWithTag:1001];
    tempLabel.frame = CGRectMake(0, 0, 10, 40);
    
    TaskR *task = [TaskR new];
    task = _taskarray[indexPath.row];
    tempLabel.backgroundColor = task.color;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个任务:%@",indexPath.row + 1,task.title];
    //cell.textLabel.text = task.title;
    cell.detailTextLabel.text = task.time;
    
    return cell;
    }

#pragma mark - view将要出现调用的方法
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    _taskarray = mol.taskArray;
   
    if (![NSKeyedUnarchiver unarchiveObjectWithFile:_path]) {
        
        mol = [MessageMoel shareInstance];
    }
    _taskarray = [NSMutableArray array];
    mol = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];

    _taskarray = mol.taskArray;
    
    [_tabelView reloadData];
}

#pragma mark - 点击某一个cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SeconderViewController *secV = [SeconderViewController new];
    [self presentViewController:secV animated:YES completion:^{
        
    }];
    //secV.viewC = self;
    self.delegate = (id)secV;
    //单例里面存的每一次都只有一个。
    mol.indexPathl = indexPath;
    
    [NSKeyedArchiver archiveRootObject:mol toFile:_path];
    [self.delegate messageSend:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 左划编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    indexpath = indexPath;
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        [self showAlert];
    }
}

#pragma mark - 弹框
- (void)showAlert{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"⚠️" message:@"确定删除吗" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        mol = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
        [mol.taskArray removeObjectAtIndex:indexpath.row];
        [NSKeyedArchiver archiveRootObject:mol toFile:_path];
        
        _taskarray = mol.taskArray;
        
        [_tabelView reloadData];
        
        NSLog(@"删除!");
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"取消");
    }];
    
    [alertController addAction:alertAction];
    [alertController addAction:alertAction2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
