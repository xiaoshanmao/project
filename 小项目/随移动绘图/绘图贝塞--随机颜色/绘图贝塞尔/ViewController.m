//
//  ViewController.m
//  绘图贝塞尔
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "customView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    customView *customview = [[customView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:customview];
    customview.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
