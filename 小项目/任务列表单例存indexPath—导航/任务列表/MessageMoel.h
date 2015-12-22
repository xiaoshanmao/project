//
//  MessageMoel.h
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskR.h"
@interface MessageMoel : NSObject

@property (nonatomic,strong)NSMutableArray *taskArray;
@property (nonatomic,strong)NSIndexPath *indexPathl;

+ (instancetype)shareInstance;
@end
