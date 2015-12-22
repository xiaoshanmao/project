//
//  ScrollView.h
//  scrollView
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIScrollView

@property (nonatomic ,strong)NSArray *imageArray;
@property (nonatomic ,strong)NSArray *stringArray;

- (void)demoFunc:(void(^)(NSInteger a))blc;

@end
