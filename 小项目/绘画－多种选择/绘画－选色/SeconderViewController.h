//
//  SeconderViewController.h
//  绘画－选色
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol colorDelegate <NSObject>

- (void)colorDelegate:(UIColor *)color;

@end
@interface SeconderViewController : UIViewController

@property (nonatomic,weak)id<colorDelegate>delegate;
@end
