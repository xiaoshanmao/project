//
//  TitleView1.m
//  buDing —1
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "TitleView1.h"
#import "Masonry.h"
#import "ViewController.h"
@interface TitleView1()<indexDelegate>
{
    UIView *_view;
    UIButton *_tempButton;
    void(^tempBlc)(UIButton *button ,NSInteger index);
    UIButton *button1;
    UIButton *button2;
}
@end
@implementation TitleView1

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        button1 = [self buttonWithTitle:@"推荐" andTag:3001];
        button1.selected = YES;
        _tempButton = button1;
        [self addSubview:button1];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom).with.offset(-3);
            make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
        }];
        
        
        button2 = [self buttonWithTitle:@"分类" andTag:3002];
        [self addSubview:button2];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(button1);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(button1.mas_bottom);
            make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
        }];
        
        _view = [UIView new];
        _view.backgroundColor = [UIColor redColor];
        [self addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(button1.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
        }];
    }
    return self;
}

- (void)whichButtonClicked:(void(^)(UIButton *button, NSInteger index))blc{
    
    tempBlc = ^(UIButton *button, NSInteger index){
        
        blc(button,index);
    };
}

//滑动的代理方法
- (void)indexDelegate:(NSInteger)index{
    
    if (index == 0) {
        
         [self lineViewToLeft:button2];
    }else {

         [self lineViewToRight:button1];
    }
}


- (UIButton *)buttonWithTitle:(NSString *)title andTag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClicked:(UIButton *)sender{
    
    _tempButton.selected = NO;
    sender.selected = YES;
    _tempButton = sender;
    
    if (tempBlc) {
     
        tempBlc(sender,sender.tag - 3000);
    }
    
    if ([sender.currentTitle isEqualToString:@"分类"]) {
     
        [self lineViewToRight:sender];
    }else{
        
        [self lineViewToLeft:sender];
    }
}

- (void)lineViewToRight:(UIButton *)sender{
    
    button1.titleLabel.textColor = [UIColor blackColor];
    button2.titleLabel.textColor = [UIColor redColor];
//    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sender.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    [UIView animateWithDuration:0.35 animations:^{
        
        [self layoutIfNeeded];
        
    } completion:nil];
    
}

- (void)lineViewToLeft:(UIButton *)sender{
    
//    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button2.titleLabel.textColor = [UIColor blackColor];
    button1.titleLabel.textColor = [UIColor redColor];

    [_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sender.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
    }];
    [UIView animateWithDuration:0.35 animations:^{
        
        [self layoutIfNeeded];
        
    } completion:nil];
}


@end
