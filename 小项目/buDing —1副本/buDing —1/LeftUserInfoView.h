//
//  LeftUserInfoView.h
//  buDing —1
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftUserInfoView : UIView

@property (nonatomic,strong,nullable)UIImage *avatarImage;
@property (nonatomic,strong,nullable)UILabel *nicknameLabel;
@property (nonatomic,assign)NSUInteger followCount;
@property (nonatomic,assign)NSUInteger fanCount;

@property (nonatomic ,assign)BOOL isLogin;

//导出三个⼦子控件的事件设置
- (void)addAvatarTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)addFollowerTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)addFansTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
