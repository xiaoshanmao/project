//
//  LeftFootView.m
//  buDing —1
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "LeftFootView.h"

@implementation LeftFootView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
       
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1001;
        [self addSubview:button];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.tag = 1002;
        [self addSubview:button1];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
