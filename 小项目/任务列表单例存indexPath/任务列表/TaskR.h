//
//  TaskR.h
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TaskR : NSObject<NSCoding>


@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)UIColor *color;
@property (nonatomic,copy)NSString *time;

@end
