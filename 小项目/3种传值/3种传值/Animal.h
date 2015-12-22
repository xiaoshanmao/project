//
//  Animal.h
//  3种传值
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timeBlock)(int a);

@protocol animalDelegate <NSObject>

@optional
- (void)getTheValueFromDelegate:(int)num;

@end

@interface Animal : NSObject

@property (nonatomic,weak)id<animalDelegate> delegate;

@property (nonatomic,strong)timeBlock block;

- (void)launch;

- (void)tempAdd;

- (void)numFromBlo:(timeBlock)blc;

//- (void)numForDelegate;
@end
