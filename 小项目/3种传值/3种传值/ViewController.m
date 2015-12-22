//
//  ViewController.m
//  3种传值
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"
@interface ViewController ()<animalDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Animal *animal = [Animal new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getValueFromNoti:) name:@"notikey" object:nil];
    
    
    
    animal.delegate = self;
  
    
    [animal launch];
    
    [animal numFromBlo:^(int a) {
        
        NSLog(@"block:%d",a);
    }];
    
    
    animal.block =^(int a) {
        
        NSLog(@"block属性:%d",a);
    };
}


- (void)getValueFromNoti:(NSNotification *)noti
{
    NSLog(@"通知：%@",[noti object]);
}


- (void)getTheValueFromDelegate:(int)num{
   
    NSLog(@"代理:%d",num);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notikey" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
