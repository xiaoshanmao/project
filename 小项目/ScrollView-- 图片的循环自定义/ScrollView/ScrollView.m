//
//  ScrollView.m
//  ScrollView
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ScrollView.h"
@interface ScrollView()<UIScrollViewDelegate>
{
    ScrollView *_scrollView;
    CGSize _size;
}
@end

@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _size = frame.size;
        for (int i = 0; i<3; i++) {
            
            
        }
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArrayl{
    
    _imageArray = imageArrayl;
}
@end



