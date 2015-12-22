//
//  ViewController.h
//  TabelViewquibia
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewControllerDelegate<NSObject>

@optional
- (void)messageSend:(NSString *)string;

@end
@interface ViewController : UIViewController

@property (nonatomic,weak)id<ViewControllerDelegate>delegate;

@end

