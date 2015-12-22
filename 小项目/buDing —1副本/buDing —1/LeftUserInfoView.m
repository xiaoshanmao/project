//
//  LeftUserInfoView.m
//  buDing —1
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "LeftUserInfoView.h"
#import "Masonry.h"
@interface LeftUserInfoView()
{
    UIButton *_avatarButton;
    UIButton *_followButton;
    UIButton *_fanButton;
    
}
@end
@implementation LeftUserInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self creatAvatarButton];
        [self creatNicknameLabel];
        [self creatFollowButton];
        [self creatFanButton];
    }
    return self;
}


- (void)creatAvatarButton{
    
    _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_avatarButton setBackgroundImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    //[_avatarButton setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    //设置圆角
    _avatarButton.layer.cornerRadius = 40;
    _avatarButton.layer.masksToBounds = YES;
    [self addSubview:_avatarButton];
    
    [_avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.left.equalTo(@96);
        make.size.equalTo(MASBoxValue(CGSizeMake(80, 80)));
    }];
}


- (void)creatNicknameLabel{
    
    _nicknameLabel = [[UILabel alloc] init];
    _nicknameLabel.textAlignment = NSTextAlignmentCenter;
    _nicknameLabel.text = @"登录以获取追番纪录";
    _nicknameLabel.textColor = [UIColor whiteColor];
    _nicknameLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_nicknameLabel];
    
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker
                                          *make) {
        make.top.equalTo(_avatarButton.mas_bottom).offset(10);
        make.centerX.equalTo(_avatarButton.mas_centerX);
        make.size.equalTo(MASBoxValue(CGSizeMake(200, 40)));
    }];
}

- (void)creatFollowButton{
    
    _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮⽂文本的数字部分由变量拼装
    [_followButton setTitle:[NSString stringWithFormat:@"关注 %ld",(unsigned long)_followCount] forState:UIControlStateNormal];
    [self addSubview:_followButton];
    [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nicknameLabel.mas_bottom).offset(10);
        make.right.equalTo(_nicknameLabel.mas_centerX);
        make.size.equalTo(MASBoxValue(CGSizeMake(120, 40)));
    }];
}

- (void)creatFanButton{
    
    _fanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //按钮⽂文本的数字部分由变量拼装
    [_fanButton setTitle:[NSString stringWithFormat:@"粉丝 %ld",(unsigned long)_fanCount] forState:UIControlStateNormal];
    [self addSubview:_fanButton];
    [_fanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nicknameLabel.mas_bottom).offset(10);
        make.left.equalTo(_nicknameLabel.mas_centerX);
        make.size.equalTo(MASBoxValue(CGSizeMake(120, 40)));
    }];
}

#pragma mark targets/actions
- (void)addAvatarTarget:(id)target action:(SEL)action
       forControlEvents:(UIControlEvents)controlEvents
{
    [_avatarButton addTarget:target action:action
            forControlEvents:controlEvents];
}

- (void)addFollowerTarget:(id)target action:(SEL)action
         forControlEvents:(UIControlEvents)controlEvents
{
    [_followButton addTarget:target action:action
              forControlEvents:controlEvents];
}

- (void)addFansTarget:(id)target action:(SEL)action
     forControlEvents:(UIControlEvents)controlEvents
{
    [_fanButton addTarget:target action:action
          forControlEvents:controlEvents];
}

#pragma mark set方法
- (void)setAvatarImage:(UIImage *)avatorImage
{
    [_avatarButton setBackgroundImage:avatorImage forState:UIControlStateNormal];
}

- (void)setFollowCount:(NSUInteger)followCountl{
    
    _followCount = followCountl;
    [_followButton setTitle:[NSString stringWithFormat:@"关注 %ld",(unsigned long)_followCount] forState:UIControlStateNormal];
}

- (void)setFanCount:(NSUInteger)fanCountl{
    
    _fanCount = fanCountl;
    [_fanButton setTitle:[NSString stringWithFormat:@"粉丝 %ld",(unsigned long)_fanCount] forState:UIControlStateNormal];
}

- (void)setIsLogin:(BOOL)isLogin{
    
    _fanButton.hidden = !isLogin;
    _followButton.hidden = !isLogin;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//登头像外面的白光
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(92,57,88,88)];
    [[UIColor colorWithWhite:1 alpha:0.5]setStroke];
    path.lineWidth = 2;
    [path stroke];
}


@end
