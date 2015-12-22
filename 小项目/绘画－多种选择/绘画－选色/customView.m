//
//  customView.m
//  绘画－选色
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "customView.h"
#import "SeconderViewController.h"
#import "ViewController.h"
@interface customView()<colorDelegate,clearColorDelegate>
{
    NSMutableArray *_lineArray;
    NSMutableArray *_color;
    NSMutableArray *_colorArray;
    int b;
   // CGPoint  movePointl;
    NSMutableArray *_movepointArray;
    NSMutableArray *_beginpointArray;
}
@end
@implementation customView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _lineArray = [NSMutableArray array];
        _color = [NSMutableArray array];
        _colorArray = [NSMutableArray array];
        _movepointArray = [NSMutableArray array];
        _beginpointArray = [NSMutableArray array];
    }
    return self;
}


- (void)colorDelegate:(UIColor *)color{

    [_color addObject:color];
}

- (void)clearColorDelegate{
    
    [_color addObject:[UIColor whiteColor]];
}

- (void)clearDelegate{
    
    [_color removeAllObjects];
    [_lineArray removeAllObjects];
}

- (void)buttonWithNumber:(int)a{
    
    b = a;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint beginPoint = [touch locationInView:self];
    
    if ([_color count] == 0) {
        
        [_colorArray addObject:[UIColor blackColor]];
    }else{
        
        UIColor *tempColor = [_color lastObject];
        [_colorArray addObject:tempColor];
    }
    
    if (b == 0) {
        
      UIBezierPath *path = [UIBezierPath bezierPath];
      [path moveToPoint:beginPoint];
      [_lineArray addObject:path];
      [_beginpointArray addObject:@"1"];
        
    }else{
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [_lineArray addObject:path];
        NSValue *pointValue = [NSValue valueWithCGPoint:beginPoint];
        [_beginpointArray addObject:pointValue];
    }

   
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    UITouch *tempTouch = [touches anyObject];
//    CGPoint  endPoint = [tempTouch locationInView:self];
//    
//    NSValue *pointValue = [NSValue valueWithCGPoint:endPoint];
//    [_movepointArray addObject:pointValue];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *tempTouch = [touches anyObject];
    CGPoint  movePoint = [tempTouch locationInView:self];
    //CGRect rect =[value CGRectValue];
   // movePointl = movePoint;
   
    
    if (b == 0) {
        
        UIBezierPath *tempPath = [_lineArray lastObject];
         [tempPath addLineToPoint:movePoint];
         [_movepointArray addObject:@"1"];
    }
    else{
        
         NSValue *pointValue = [NSValue valueWithCGPoint:movePoint];
        [_movepointArray addObject:pointValue];
    }
     [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

    if (b == 0) {
    
    for (int i = 0; i<[_lineArray count]; i++) {
        
        if ([_beginpointArray[i] isEqual:@"1"]) {
            
        [_colorArray[i] setStroke];
        UIBezierPath *path = _lineArray[i];
        path.lineWidth = 11;
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineCapStyle = kCGLineCapRound;

        [path stroke];
        }
        
    }
    }else{
        
        for (int i = 0; i<[_lineArray count]; i++) {
            
            if (![_beginpointArray[i] isEqual:@"1"]) {
                
            [_colorArray[i] setStroke];
            UIBezierPath *path = _lineArray[i];
            NSValue *value = [_movepointArray lastObject];
            CGPoint movePoint = [value CGPointValue];
                
            NSValue *value1 = [_beginpointArray lastObject];
            CGPoint beginPoint = [value1 CGPointValue];
            
            [path moveToPoint:beginPoint];
            [path addLineToPoint:movePoint];
                
                
            path.lineWidth = 11;
            path.lineJoinStyle = kCGLineJoinRound;
            path.lineCapStyle = kCGLineCapRound;
            
            [path stroke];
            }
        }
    }
 
}

@end
