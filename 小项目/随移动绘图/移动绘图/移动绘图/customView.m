//
//  customView.m
//  移动绘图
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "customView.h"
@interface customView()
{
    CGPoint pointBegin;
    NSMutableArray *array;
    NSMutableDictionary *dict;
    int a;
}
@end
@implementation customView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    pointBegin = point;
    a++;
    NSLog(@"%d",a);
    [self setNeedsDisplay];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSValue *value = [NSValue valueWithCGPoint:point];
    
    [array addObject:value];
    [self setNeedsDisplay];
    
}
- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor redColor]setStroke];
    
    CGContextSetLineWidth(context, 10);
    
    CGContextMoveToPoint(context, pointBegin.x, pointBegin.y);
    if (array == nil) {
        
        array = [NSMutableArray array];
    }
    for (NSValue *value in array) {

        CGPoint point = [value CGPointValue];
        
        CGContextAddLineToPoint(context, point.x, point.y);
    }

    CGContextStrokePath(context);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[dict setObject:array forKey:@"bo"];
}
@end
