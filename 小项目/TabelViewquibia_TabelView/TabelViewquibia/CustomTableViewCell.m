//
//  CustomTableViewCell.m
//  TabelViewquibia
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"
#import "UIKit+AFNetworking.h"

@interface CustomTableViewCell()
{
    UILabel *_labelNickName;
    UILabel *_label2;
    UIImageView *_imageView;
}
@end
@implementation CustomTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            make.left.equalTo(self.mas_left);
            make.height.equalTo(@45);
            make.width.equalTo(@50);
        }];
        
        _labelNickName = [UILabel new];
        _labelNickName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_labelNickName];
        
        [_labelNickName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).with.offset(5);
            make.left.equalTo(_imageView.mas_left).with.offset(5);
            make.width.equalTo(@300);
            make.height.equalTo(@25);
        }];
        
        _label2 = [UILabel new];
        _label2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label2];
        
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_labelNickName.mas_bottom);
            make.left.equalTo(_labelNickName);
            make.width.equalTo(_labelNickName);
            make.height.equalTo(@20);
        }];

    }
    
    return self;
}

- (void)setLimage:(NSString *)limage{
    
    [_imageView setImageWithURL:[NSURL URLWithString:limage] placeholderImage:[UIImage imageNamed:@"test1.jpg"]];
}


- (void)setTextNickName:(NSString *)textNickName{
    
    _labelNickName.text = textNickName;
}


- (void)setText1:(NSString *)text1{
    
    _label2.text = text1;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
