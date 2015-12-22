//
//  ViewController.m
//  DemoOC_58
//
//  Created by frankfan on 15/11/20.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
#import "Animal.h"

@interface ViewController ()
{
    UIButton *tempButton;
    UIView *view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    NSDictionary *dict = @{@"title":@"demo_title",@"content":@"demo_content",@"index":@222};
    
    Animal *animal = [[Animal alloc]initWithDict:dict];
#endif
    
#if 0
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor = [UIColor redColor];
    button2.frame = CGRectMake(0, 110, 100, 100);
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.backgroundColor = [UIColor redColor];
    button3.frame = CGRectMake(0, 220, 100, 100);
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    tempButton = button;
    [tempButton addSubview:view];
#endif
    
    CustomButton *customButton = [[CustomButton alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    customButton.whichIndex = 1;
    [self.view addSubview:customButton];
    
    [customButton whichButtonClicked:^(NSInteger index, UIButton *button) {
        
        NSLog(@"-->%ld",index);
    }];
}


- (void)buttonClicked:(UIButton *)sender{

    tempButton.backgroundColor = [UIColor redColor];
    tempButton = sender;
    sender.backgroundColor = [UIColor greenColor];
//    [tempButton addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
