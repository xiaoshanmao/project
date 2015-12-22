//
//  customView.m
//  绘图——进度条
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "customView.h"
#import "ViewController.h"
@interface customView()<MessageDelegate>
{
    NSTimer *timer;
    int b;
}
@end
@implementation customView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)messageSend:(int)a{
    
    b = a;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
   
  
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, 200, 200, 100, 0, M_PI/180+b, 0);
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 10);
    CGContextStrokePath(context);
   
}


@end
