//
//  ViewController.m
//  touch
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGPoint fristTouchPoint;
    CGPoint originPoint;
    CGPoint fristTouchPoint1;
    CGPoint originPoint1;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    view1.backgroundColor = [UIColor orangeColor];
   // [self.view addSubview:view1];
    view1.tag = 1001;
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    view2.backgroundColor = [UIColor grayColor];
    //[self.view addSubview:view2];
    view2.tag = 1002;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    UIView *tempView = touch.view;
    if(tempView.tag == 1001){
        
        NSLog(@"点击红色的View");
    }else if (tempView.tag == 1002){
        
        NSLog(@"点击绿色的View");
    }
    if (tempView.tag == 1003)
    {
       fristTouchPoint = point;
       originPoint = tempView.frame.origin;
        //[tempView removeFromSuperview];
    }
    else
    {
       fristTouchPoint = point;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    UIView *tempView = touch.view;
    //位置会突变。
//    if(tempView.tag == 1001){
//        tempView.frame = CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y, point.x, point.y);
//        NSLog(@"点击红色的View");
//    }else if (tempView.tag == 1002){
//         tempView.frame = CGRectMake(point.x,point.y, tempView.frame.size.width, tempView.frame.size.height);
//        NSLog(@"点击灰色的View");
//    }
    CGFloat d_x = point.x - fristTouchPoint.x;
    CGFloat d_y = point.y - fristTouchPoint.y;

    if (tempView.tag == 1003 ) {
       // [tempView removeFromSuperview];
        tempView.frame = CGRectMake(originPoint.x + d_x, originPoint.x + d_y, tempView.frame.size.width, tempView.frame.size.height);
    }else
    {
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor orangeColor];
        view1.frame = CGRectMake(fristTouchPoint.x, fristTouchPoint.y, d_x, d_y);
        view1.tag = 1003;
        [self.view addSubview:view1];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
