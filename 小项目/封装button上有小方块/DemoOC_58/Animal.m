//
//  Animal.m
//  DemoOC_58
//
//  Created by frankfan on 15/11/20.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "Animal.h"

@implementation Animal


- (instancetype)initWithDict:(NSDictionary *)dict{

    self = [super init];
    if (self) {
 
        NSArray *keys = [dict allKeys];
        for (NSString *tempKey in keys) {
            
            id value = dict[tempKey];
            [self setValue:value forKey:tempKey];
        }
    }
    
    return self;
}
@end
