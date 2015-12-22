//
//  ViewController.m
//  magicPan
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *_path;
    NSMutableArray *_views;
    CGPoint _originPoint;
    CGPoint _currentPoint;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _path = @"Users/apple/Desktop/rect.plist";
   // NSFileManager *fileManager = [NSFileManager defaultManager];
    if([NSKeyedUnarchiver unarchiveObjectWithFile:_path]){
        
        _views = [NSMutableArray array];
        [NSKeyedArchiver archiveRootObject:_views toFile:_path];
    }
    _views = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    
    for (UIView *view in _views)
    {
        [self.view addSubview:view];
    }
    self.view.tag = 1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (touch.view.tag == 1)
    {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor orangeColor];
       // _originPoint = point;
        [self.view addSubview:view];
        _originPoint = point;
        [_views addObject:view];
    }else
    {
        UIView *view = touch.view;
        _originPoint = CGPointMake(view.frame.origin.x, view.frame.origin.y);
        _currentPoint = point;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (touch.view.tag == 1)
    {
        UIView *view = [_views lastObject];
        CGFloat d_x = point.x - _originPoint.x;
        CGFloat d_y = point.y - _originPoint.y;
        view.frame = CGRectMake(_originPoint.x, _originPoint.y, d_x, d_y);
    }else
    {
        UIView *view = touch.view;
        //移动的点距离开始点的纪录。
        CGFloat d_x = point.x - _currentPoint.x;
        CGFloat d_y = point.y - _currentPoint.y;
        
        view.frame = CGRectMake(_originPoint.x + d_x, _originPoint.y + d_y, view.frame.size.width, view.frame.size.height);
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSKeyedArchiver archiveRootObject:_views toFile:_path];
}


- (IBAction)clearButtonClicked:(id)sender {
    
    NSArray *views = [self.view subviews];
    for (UIView *view in views) {
        if (view.tag != 1001) {
            [view removeFromSuperview];
        }
    }
    [_views removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_views toFile:_path];
}








- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
