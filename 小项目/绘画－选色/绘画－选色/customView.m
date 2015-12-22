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
    int a;
}
@end
@implementation customView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _lineArray = [NSMutableArray array];
        _color = [NSMutableArray array];
        _colorArray = [NSMutableArray array];
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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint beginPoint = [touch locationInView:self];
   
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:beginPoint];
    
    if ([_color count] == 0) {
       
        [_colorArray addObject:[UIColor blackColor]];
    }else{
    
    UIColor *tempColor = [_color lastObject];
    [_colorArray addObject:tempColor];
    }
    [_lineArray addObject:path];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *tempTouch = [touches anyObject];
    CGPoint  movePoint = [tempTouch locationInView:self];
    
    UIBezierPath *tempPath = [_lineArray lastObject];
    [tempPath addLineToPoint:movePoint];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {

    for (int i = 0; i<[_lineArray count]; i++) {
        
        [_colorArray[i] setStroke];
        UIBezierPath *path = _lineArray[i];
        path.lineWidth = 11;
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineCapStyle = kCGLineCapRound;

        [path stroke];
    }

}

@end
