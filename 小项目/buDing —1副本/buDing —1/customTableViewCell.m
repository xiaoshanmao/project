//
//  customTableViewCell.m
//  buDing —1
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "customTableViewCell.h"
#import "Masonry.h"
@interface customTableViewCell()
{
    UILabel *_label;
    UIImageView *_imageView;
}
@end
@implementation customTableViewCell

- (void)awakeFromNib {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).with.offset(10);
            make.left.equalTo(self.mas_left).offset(20);
            make.height.equalTo(@40);
            make.width.equalTo(@45);
        }];
        
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).with.offset(15);
            make.left.equalTo(_imageView.mas_right).with.offset(20);
            make.width.equalTo(@200);
            make.height.equalTo(@40);
        }];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setLimage:(UIImage *)limage{
    
    _imageView.image = limage;
}

- (void)setCenterText:(NSString *)centerText{
    
    _label.text = centerText;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
