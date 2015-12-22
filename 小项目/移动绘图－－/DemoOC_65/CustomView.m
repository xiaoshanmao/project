//
//  CustomView.m
//  DemoOC_65
//
//  Created by frankfan on 15/11/25.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()
{

    NSMutableArray *_lines;
}
@end


@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _lines = [NSMutableArray array];
    }
    
    return self;

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CGContextRef contxtRef = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contxtRef, 10);
    CGContextSetLineCap(contxtRef, kCGLineCapRound);
    CGContextSetLineJoin(contxtRef, kCGLineJoinRound);
    
    for (int i = 0; i<[_lines count]; i++) {
        
        [[self randomcolor]setStroke];
        NSMutableArray *points = _lines[i];
        NSValue *beginPointValue = [points firstObject];
        CGPoint beginPoint = [beginPointValue CGPointValue];

        CGContextMoveToPoint(contxtRef, beginPoint.x, beginPoint.y);

        for (NSValue *pointValue in points) {
            
            CGPoint movePoint = [pointValue CGPointValue];
            CGContextAddLineToPoint(contxtRef, movePoint.x, movePoint.y);
        }
        
        CGContextStrokePath(contxtRef);
    }
    
#if 0
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor redColor]setStroke];
    path.lineWidth = 11;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(22, 22)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    [path stroke];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *tempTouch = [touches anyObject];
    CGPoint beginPoint = [tempTouch locationInView:self];
    NSValue *beginPointValue = [NSValue valueWithCGPoint:beginPoint];

    NSMutableArray *points = [NSMutableArray array];
    [points addObject:beginPointValue];
    
    [_lines addObject:points];
    
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *tempTouch = [touches anyObject];
    CGPoint movePoint = [tempTouch locationInView:self];
    NSValue *movePointValue = [NSValue valueWithCGPoint:movePoint];
    
    NSMutableArray *points = [_lines lastObject];
    [points addObject:movePointValue];
    
    [self setNeedsDisplay];
}



@end
