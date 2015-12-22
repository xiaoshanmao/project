//
//  ViewController.m
//  DemoOC_65
//
//  Created by frankfan on 15/11/25.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    CustomView *customView = [[CustomView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:customView];
    customView.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
