//
//  TitleView1.h
//  buDing —1
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView1 : UIView

- (void)whichButtonClicked:(void(^)(UIButton *button, NSInteger index))blc;

- (void)indexDelegate:(NSInteger)index;
@end
