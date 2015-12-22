//
//  Concact.m
//  concacts
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "Concact.h"

@implementation Concact

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSArray *allkeys = [dict allKeys];
        for (id tmp in allkeys) {
            [self setValue:dict[tmp] forKey:tmp];
        }
    }
    return self;
}

- (NSMutableDictionary *)WithConcact:(Concact *)concact
{
     NSMutableDictionary *singeDic = [NSMutableDictionary dictionary];
    [singeDic setObject:concact.name forKey:@"name"];
    [singeDic setObject:concact.gender forKey:@"name"];
    [singeDic setObject:concact.company forKey:@"company"];
    [singeDic setObject:concact.occupation forKey:@"occupation"];
    [singeDic setObject:concact.phone forKey:@"phone"];
    [singeDic setObject:concact.email forKey:@"email"];
    [singeDic setObject:concact.wechat forKey:@"wechat"];
    return singeDic;
}
@end
