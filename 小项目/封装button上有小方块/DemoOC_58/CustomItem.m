//
//  CustomItem.m
//  DemoOC_58
//
//  Created by frankfan on 15/11/20.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "CustomItem.h"
#import "Masonry.h"

@interface CustomItem ()
{
    UIView *_view;
}
@end

@implementation CustomItem

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _view = [UIView new];
        _view.backgroundColor = [UIColor whiteColor];
        [self addSubview:_view];
        _view.hidden = YES;
        
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self);
            make.width.and.height.equalTo(@30);
        }];
    }
    
    return self;

}

- (void)setHideIt:(BOOL)hideIt{

    _view.hidden = hideIt;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
