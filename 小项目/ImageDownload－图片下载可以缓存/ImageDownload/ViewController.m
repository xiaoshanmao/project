//
//  ViewController.m
//  ImageDownload
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Download1.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:view];
    [view custom_setImageWithURL:[NSURL URLWithString:@"http://img.firefoxchina.cn/2015/12/4/201512101921290.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
