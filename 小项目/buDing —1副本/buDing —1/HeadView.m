//
//  HeadView.m
//  buDing —1
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "HeadView.h"
@interface HeadView()
{
  void(^tempBlc)(UIButton *button);
}
@end
@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
      
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * leftItemImage = [UIImage imageNamed:@"default_avatar"];
        [self addSubview:imageButton];
        [imageButton setImage:leftItemImage forState:UIControlStateNormal];
        [imageButton addTarget:self action:@selector(headerIconCliked:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.frame = CGRectMake(5, 5, 30, 30);
        imageButton.layer.cornerRadius = 15;
        imageButton.layer.masksToBounds = YES;
        
        UIImage *image = [UIImage imageNamed:@"home_icon_more"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 15, 5, 15);
        [self addSubview:imageView];
        
    }
    return self;
}

- (void)headerIconCliked:(UIButton *)sender{
    
    if (tempBlc) {
    
        tempBlc(sender);
    }
}

- (void)whichButtonClicked:(void(^)(UIButton *button))blc{
    
    tempBlc = ^(UIButton *button){
       
        blc(button);
    };
}
@end
