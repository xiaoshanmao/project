//
//  titleview.h
//  buDing —1
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface titleview : UIView
- (void)whichButtonClicked:(void (^)(UIButton *button, NSInteger a))blc;
@end
