//
//  SeconderViewController.m
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "SeconderViewController.h"
#import "TaskR.h"
#import "Masonry.h"
#import "MessageMoel.h"
#import "ViewController.h"
@interface SeconderViewController ()<MessageDelegate>
{
    TaskR *task;
    UITextField *_textField;
    UITextView *_textView;
    UIColor *a;//保存颜色的中间变量
    UIButton *_button;
    UIView *_view;
    MessageMoel *mol;//单例对象
    NSIndexPath *indexPath_;//cell没被点击时的indexPath_
    NSString *_path;//保存的地址路径
}
@end

@implementation SeconderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _path = @"/Users/apple/Desktop/task.plist1";
    
//在cell没被点击时的indexPath_用于判断。
    indexPath_ = [NSIndexPath indexPathForRow:10000 inSection:0];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor greenColor];
    label.text = @"添加新任务";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.right.and.left.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"✔️" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(label.mas_top).with.offset(5);
        make.right.equalTo(label.mas_right).with.offset(-5);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [button addTarget:self action:@selector(lbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    _textField = [UITextField new];
    _textField.backgroundColor = [UIColor orangeColor];
    _textField.layer.cornerRadius = 5;//圆角半径
    [self.view addSubview:_textField];
    
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(label.mas_bottom).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.height.equalTo(@40);
    }];
    
    _textView = [UITextView new];
    _textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_textField.mas_bottom).with.offset(7);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.height.equalTo(@280);
    }];
    
    UIView *labelBottom = [UIView new];
    labelBottom.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labelBottom];
    [labelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_textView.mas_bottom).with.offset(0);
        make.right.and.left.equalTo(_textView);
        make.height.equalTo(@44);
    }];
    
    // 按钮1⃣️
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
//    [button1 setTitle:@"√" forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button1.layer.cornerRadius = 20;
    [labelBottom addSubview:button1];
    button1.tag = 1001;
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(labelBottom.mas_right).with.offset(-5);
        make.top.equalTo(labelBottom.mas_top).with.offset(2);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    // 按钮2⃣️
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor = [UIColor greenColor];
    [labelBottom addSubview:button2];
    
    button2.layer.cornerRadius = 20;
    button2.tag = 1002;
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(labelBottom.mas_top).with.offset(2);
        make.right.equalTo(button1.mas_left).with.offset(-5);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    //按钮3⃣️
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.backgroundColor = [UIColor cyanColor];
    [labelBottom addSubview:button3];
    
    button3.layer.cornerRadius = 20;
    button3.tag = 1003;
    [button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(labelBottom.mas_top).with.offset(2);
        make.right.equalTo(button2.mas_left).with.offset(-5);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    //按钮4⃣️
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.backgroundColor = [UIColor yellowColor];
    [labelBottom addSubview:button4];

    button4.layer.cornerRadius = 20;
    button4.tag = 1004;
    [button4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(labelBottom.mas_top).with.offset(2);
        make.right.equalTo(button3.mas_left).with.offset(-5);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
    button3.layer.cornerRadius = 20;
    _view.backgroundColor = [UIColor blackColor];
    
    _button = button1;
    [_button addSubview: _view];
}


#pragma mark - 点击一个cell传递indexPath的代理方法。
- (void)messageSend:(NSIndexPath *)indexPath{
    
    indexPath_ = indexPath;
    mol = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/apple/Desktop/task.plist"];
    task = mol.taskArray[indexPath.row];
    _textField.text = task.title;
    _textView.text = task.content;
    
}


#pragma mark - 保存按钮点击
- (void)lbuttonClicked:(UIButton *)sender{
   //修改已经保存的。
  
   [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    mol = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    if (mol.taskArray.count==0) {
        
        [self creatNewTask];

   }else {
       
       if (indexPath_.row == 10000) {
        
           [self creatNewTask];
       }else{
           
           task.title = _textField.text;
           task.content = _textView.text;
           task.time = [self today];
           task.color = a;
           mol.taskArray[indexPath_.row] = task;
           [NSKeyedArchiver archiveRootObject:mol toFile:_path];
           
           indexPath_ = [NSIndexPath indexPathForRow:10000 inSection:0];
       }
   }
}

#pragma mark - 创建一个新的对象
- (void)creatNewTask{
    
    task = [TaskR new];
    task.title = _textField.text;
    task.content = _textView.text;
    task.time = [self today];
    task.color = a;
    
    
    if (![NSKeyedUnarchiver unarchiveObjectWithFile:_path]) {
        
        mol = [MessageMoel shareInstance];
    }else{
        
        mol = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    }
    if (mol.taskArray == nil) {
        
        mol.taskArray = [NSMutableArray array];
    }
    
    [mol.taskArray addObject:task];
    
    [NSKeyedArchiver archiveRootObject:mol toFile:_path];
}


#pragma mark - 颜色button点击
- (void)buttonClicked:(UIButton *)sender{
    
    task = [TaskR new];
    if (sender.tag == 1001) {
        
        _button = sender;
        [_button addSubview: _view];
      
       a = [UIColor redColor];
    }
    if (sender.tag == 1002) {
        
        _button = sender;
        [_button addSubview: _view];
        a = [UIColor greenColor];
    }
    if (sender.tag == 1003) {
       
        _button = sender;
        [_button addSubview: _view];
        a = [UIColor cyanColor];
    }
    if (sender.tag == 1004) {
       
        _button = sender;
        [_button addSubview: _view];
         a = [UIColor yellowColor];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

#pragma mark - 返回日期的方法
- (NSString *)today{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
