//
//  ViewController.m
//  移动绘图
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "customView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    customView *cView = [[customView alloc] initWithFrame:self.view.frame];
    cView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
