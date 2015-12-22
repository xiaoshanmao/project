//
//  Animal.h
//  DemoOC_58
//
//  Created by frankfan on 15/11/20.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)NSInteger index;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
