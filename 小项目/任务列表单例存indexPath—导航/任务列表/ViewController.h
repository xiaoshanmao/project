//
//  ViewController.h
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MessageDelegate <NSObject>
@optional
- (void)messageSend:(NSIndexPath *)indexPath;
@end


@interface ViewController : UIViewController

@property (nonatomic,weak)id<MessageDelegate>delegate;
@end

