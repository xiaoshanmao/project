//
//  Concact.h
//  concacts
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Concact : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *company;
@property (nonatomic,strong) NSString *occupation;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *wechat;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSMutableDictionary *)WithConcact:(Concact *)concact;
@end
