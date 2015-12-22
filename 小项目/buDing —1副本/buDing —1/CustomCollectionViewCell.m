//
//  CustomCollectionViewCell.m
//  buDing —1
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "Masonry.h"
#import "UIKit+AFNetworking.h"
@interface CustomCollectionViewCell()
{
    UILabel *_label;
    UIImageView *_imageView;
}
@end

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.layer.cornerRadius = 5;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.height.equalTo(self.mas_height).multipliedBy(0.7);
            make.width.equalTo(self.mas_width);
        }];
        
        _label = [UILabel new];
        //_label.backgroundColor = [UIColor orangeColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.top.equalTo(_imageView.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.height.equalTo(self.mas_height).multipliedBy(0.3);
            make.width.equalTo(self.mas_width);
        }];
    }
    return self;
}

- (void)setLimage:(NSString *)limage{
    
    [_imageView setImageWithURL:[NSURL URLWithString:limage]];
}

- (void)setCenterText:(NSString *)centerText{
    
    _label.text = centerText;
}


@end
