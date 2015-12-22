//
//  titleview.m
//  buDing —1
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "titleview.h"
#import "Masonry.h"
@interface titleview()
{
    UIButton *_recommendButton;
    UIButton *_classifyButton;
    UILabel *_recommendLabel;
    UILabel *_classifyLabel;
    UILabel *_label;
    void (^tempBlc)(UIButton *,NSInteger index);
}
@end
@implementation titleview

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        _recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recommendButton.tag = 1001;
        [self addSubview:_recommendButton];
        [_recommendButton setTitle:@"推荐" forState: UIControlStateNormal];
        [_recommendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_recommendButton addTarget:self action:@selector(innserButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _classifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _classifyButton.tag = 1002;
        [self addSubview:_classifyButton];
        [_classifyButton setTitle:@"分类" forState: UIControlStateNormal];
        [_classifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_classifyButton addTarget:self action:@selector(innserButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _recommendLabel = [UILabel new];
        _recommendLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_recommendLabel];
        
        _classifyLabel = [UILabel new];
        _classifyLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_classifyLabel];
        
        _label = [UILabel new];
        _label.backgroundColor = [UIColor grayColor];
        [self addSubview:_label];
        
        [_recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(8);
            make.left.equalTo(self.mas_left);
            make.height.equalTo(@30);
            make.width.equalTo(@60);

        }];
        
        [_classifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(8);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@30);
            make.width.equalTo(@60);
            
        }];
        
        
        [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_recommendButton.mas_bottom).offset(4);
            make.right.equalTo(_recommendButton);
            make.height.equalTo(@3);
            make.width.equalTo(@57);
        }];
        
        [_classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_classifyButton.mas_bottom).offset(4);
            make.right.equalTo(_classifyButton);
            make.height.equalTo(@3);
            make.width.equalTo(@57);
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(10);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@27);
            make.width.equalTo(@1);
        }];
    }
    return self;
}


- (void)innserButtonClicked:(UIButton *)sender{
    
    if(tempBlc){
        
        tempBlc(sender,(sender.tag - 1000));
    }
    
    if (sender.tag == 1001) {
        
        [_recommendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_classifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _recommendLabel.backgroundColor = [UIColor orangeColor];
        _classifyLabel.backgroundColor = [UIColor clearColor];
    }else{
        
        [_recommendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_classifyButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _recommendLabel.backgroundColor = [UIColor clearColor];
        _classifyLabel.backgroundColor = [UIColor orangeColor];
    }
}

- (void)whichButtonClicked:(void (^)(UIButton *, NSInteger))blc{
    
    tempBlc = ^(UIButton *button,NSInteger index){
        
        blc(button,index);
    };
}
@end
