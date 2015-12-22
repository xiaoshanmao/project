//
//  ViewController.h
//  绘画－选色
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol clearColorDelegate <NSObject>

- (void)clearColorDelegate;
//- (void)clearDelegate;
- (void)buttonWithNumber:(int)a;

@end

@interface ViewController : UIViewController

@property (nonatomic,weak)id<clearColorDelegate>delegate;

@end

