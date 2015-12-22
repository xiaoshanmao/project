//
//  customView.m
//  绘图贝塞尔
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "customView.h"
@interface customView()
{
    NSMutableArray *_lineArray;
    NSMutableArray *_color;
}
@end
@implementation customView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _lineArray = [NSMutableArray array];
        _color = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    UITouch *tempTouch = [touches anyObject];
    CGPoint beginPoint = [tempTouch locationInView:self];
 //贝塞尔曲线本身是一个对象可以直接存储可以存储在数组中（它的起点和运动点可以不在画的地方设置，只需要在画的地方取出对象然后开始画就可）如下
 //    for (UIBezierPath *path in _lineArray) {
 //        [path stroke];
 //    }
    UIBezierPath *tempPath = [UIBezierPath bezierPath];
    [tempPath moveToPoint:beginPoint];
    UIColor *color = [self randomcolor];
    [_color addObject:color];
    [_lineArray addObject:tempPath];
    
#if 0
    NSValue *beginPointValue = [NSValue valueWithCGPoint:beginPoint];
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:beginPointValue];
    
    [_lineArray addObject:points];
#endif
}


-(UIColor *)randomcolor
{
    CGFloat red=(arc4random()%256)/255.00;
    
    CGFloat blue=(arc4random()%256)/255.00;
    
    CGFloat green=(arc4random()%256)/255.00;
    
    CGFloat alpha=(arc4random()%256)/255.00;
    
    UIColor * color=[UIColor new];
    
    color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return  color;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    UITouch *tempTouch = [touches anyObject];
    CGPoint  movePoint = [tempTouch locationInView:self];
    
    UIBezierPath *tempPath = [_lineArray lastObject];
    //[[UIColor redColor] setStroke];
    [tempPath addLineToPoint:movePoint];
#if 0
    NSValue *movePointValue = [NSValue valueWithCGPoint:movePoint];
    NSMutableArray *array = [_lineArray lastObject];
    [array addObject:movePointValue];
#endif
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
//    for (UIBezierPath *path in _lineArray) {
//        
//        //[[UIColor redColor] setStroke];
//        [[self randomcolor] setStroke];
//        
//        path.lineWidth = 11;
//        path.lineJoinStyle = kCGLineJoinRound;
//        path.lineCapStyle = kCGLineCapRound;
//        
//        [path stroke];
//    }
    
    for (int i = 0; i<[_color count]; i++) {
        
        [_color[i] setStroke];
        UIBezierPath *path = _lineArray[i];
        path.lineWidth = 11;
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineCapStyle = kCGLineCapRound;
        
        [path stroke];
    }
    
#if 0
    UIBezierPath *path = [UIBezierPath bezierPath];
   // [[UIColor redColor] setStroke];
    
    path.lineWidth = 11;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    for (int i = 0; i<[_lineArray count]; i++) {
        
        NSMutableArray *points = _lineArray[i];
        NSValue *beginValue = [points firstObject];
        CGPoint beginPoint = [beginValue CGPointValue];
        
        [path moveToPoint:beginPoint];
        
        for (NSValue *pointValue in points) {
            
          CGPoint movePoint = [pointValue CGPointValue];
          [path addLineToPoint:movePoint];
        }
    }
    [path stroke];
#endif
}
@end
