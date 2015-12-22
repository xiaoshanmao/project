//
//  ViewController.h
//  绘图——进度条
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MessageDelegate <NSObject>
@optional
- (void)messageSend:(int)a;
@end
@interface ViewController : UIViewController

@property (nonatomic,weak)id<MessageDelegate>delegate;
@end

