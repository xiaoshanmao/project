//
//  CustomButton.h
//  DemoOC_58
//
//  Created by frankfan on 15/11/20.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIView

@property (nonatomic,assign)NSInteger whichIndex;

- (void)whichButtonClicked:(void(^)(NSInteger,UIButton*))blc;

@end
