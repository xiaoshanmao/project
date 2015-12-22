//
//  ScrollView.h
//  buDing —1
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIScrollView

@property (nonatomic ,strong)NSArray *imageArray;
@property (nonatomic ,strong)NSArray *stringArray;

- (void)demoFunc:(void(^)(NSInteger a))blc;

@end

