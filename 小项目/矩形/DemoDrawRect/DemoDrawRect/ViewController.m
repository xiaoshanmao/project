//
//  ViewController.m
//  DemoDrawRect
//
//  Created by frankfan on 15/10/30.
//  Copyright © 2015年 frankfan. All rights reserved.
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

- (void)viewDidLoad {
    [super viewDidLoad];

    _path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/views.plist"];
    NSLog(@"_path:%@",_path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_path]){
    
        _views = [NSMutableArray array];
        [NSKeyedArchiver archiveRootObject:_views toFile:_path];
    }
    
    _views = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    
    for (UIView *tempView in _views) {
        
        [self.view addSubview:tempView];
    }
    
    self.view.tag = 1;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if(touch.view.tag == 1){
    
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        view.tag = 1002;
        [self.view addSubview:view];
        
        _originPoint = point;
        [_views addObject:view];

    }else{
    
        UIView *tempView = touch.view;

        _currentPoint = point;
        _originPoint = CGPointMake(tempView.frame.origin.x, tempView.frame.origin.y);

    }
    
      
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if(touch.view.tag == 1){

        UIView *tempView = [_views lastObject];
        
        CGFloat det_x = point.x - _originPoint.x;
        CGFloat det_y = point.y - _originPoint.y;
        
        tempView.frame = CGRectMake(_originPoint.x, _originPoint.y, det_x, det_y);
    }else{
    
        UIView *tempView = touch.view;
        
        CGFloat det_x = point.x - _currentPoint.x;
        CGFloat det_y = point.y - _currentPoint.y;
        
        tempView.frame = CGRectMake(_originPoint.x+det_x, _originPoint.y+det_y, tempView.frame.size.width, tempView.frame.size.height);
    
    }
   
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [NSKeyedArchiver archiveRootObject:_views toFile:_path];
}


#pragma mark - clearViews
- (IBAction)clearAllButtonClicked:(UIButton *)sender {
    

    NSArray *views = [self.view subviews];
    for (UIView *tempView in views) {
        
        if(tempView.tag == 1002){
        
            [tempView removeFromSuperview];
        }
        
    }
    
    [_views removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_views toFile:_path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
