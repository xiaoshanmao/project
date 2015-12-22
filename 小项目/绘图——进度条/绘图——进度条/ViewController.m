//
//  ViewController.m
//  绘图——进度条
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "customView.h"
@interface ViewController ()
{
    NSTimer *_timer;
    customView *customview;
    int a;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    customview = [[customView alloc] initWithFrame:self.view.frame];
    self.delegate = (id)customview;
    customview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:customview];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(demoFunc:) userInfo:nil repeats:YES];
}

- (void)demoFunc:(NSTimer *)timer{
    
    
    a++;
    if (a > 720) {
        
        [timer invalidate];
    }
    //[customview setNeedsDisplay];
    [self.delegate messageSend:a];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
