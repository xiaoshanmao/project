//
//  ViewController.h
//  buDing —1
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol indexDelegate <NSObject>
- (void)indexDelegate:(NSInteger)index;
@end

@interface ViewController : UIViewController

@property(nonatomic,weak)id<indexDelegate>delegatel;

@end

