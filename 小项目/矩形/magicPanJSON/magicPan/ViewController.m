//
//  ViewController.m
//  magicPan
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "rectangle.h"
@interface ViewController ()
{
    NSString *_path;
    NSMutableArray *_views;
    CGPoint _originPoint;
    CGPoint _currentPoint;
    NSMutableArray *_rectangleArray;
    NSString *_jsonPath;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _path = @"Users/apple/Desktop/rect.plist";
    _jsonPath = @"Users/apple/Desktop/rect.txt";
    _views = [NSMutableArray array];
    _rectangleArray = [NSMutableArray array];
//    if([NSKeyedUnarchiver unarchiveObjectWithFile:_path]){
//        
//        _views = [NSMutableArray array];
//        [NSKeyedArchiver archiveRootObject:_views toFile:_path];
//    }
//    _views = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    
    
//    for (UIView *view in _views)
//    {
//        [self.view addSubview:view];
//    }
    [self loadRectFromJsonFile];
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
        rectangle *rect = [rectangle new];
        rect.x = _originPoint.x;
        rect.y = _originPoint.y;
        rect.width = d_x;
        rect.height = d_y;
        [_rectangleArray addObject:rect];
    }else
    {
        UIView *view = touch.view;
        //移动的点距离开始点的纪录。
        CGFloat d_x = point.x - _currentPoint.x;
        CGFloat d_y = point.y - _currentPoint.y;
        
        view.frame = CGRectMake(_originPoint.x + d_x, _originPoint.y + d_y, view.frame.size.width, view.frame.size.height);
        rectangle *rect = [rectangle new];
        rect.x = _originPoint.x + d_x;
        rect.y = _originPoint.y + d_y;
        rect.width = view.frame.size.width;
        rect.height = view.frame.size.height;
        [_rectangleArray addObject:rect];
    }
    NSLog(@"%@",_rectangleArray);
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[NSKeyedArchiver archiveRootObject:_views toFile:_path];
    NSMutableArray *arrayTOJson = [NSMutableArray array];
    for (rectangle *rect in _rectangleArray) {
        NSMutableDictionary *rectDic = [NSMutableDictionary dictionary];
        rectDic[@"x"] = [@(rect.x) stringValue];
        rectDic[@"y"] = [@(rect.y) stringValue];
        rectDic[@"width"] = [@(rect.width) stringValue];
        rectDic[@"height"] = [@(rect.height) stringValue];
        [arrayTOJson addObject:rectDic];
    }
    if ([NSJSONSerialization isValidJSONObject:arrayTOJson]) {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_rectangleArray options:NSJSONWritingPrettyPrinted error:nil];
    [jsonData writeToFile:_jsonPath atomically:YES];
    }
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


- (void)loadRectFromJsonFile
{
    NSData *jsonData = [NSData dataWithContentsOfFile:_jsonPath];
    if (jsonData == nil) {
        return;
    }
    NSArray *arrayFromJson = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    for (NSMutableDictionary *rectDic in arrayFromJson) {
        CGFloat x = [rectDic[@"x"] floatValue];
        CGFloat y = [rectDic[@"y"] floatValue];
        CGFloat width = [rectDic[@"width"] floatValue];
        CGFloat height = [rectDic[@"height"] floatValue];
        
        rectangle *rect = [rectangle new];
        rect.x = x;
        rect.y = y;
        rect.width = width;
        rect.height = height;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        [_views addObject:view];
        [_rectangleArray addObject:rect];
    }
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
