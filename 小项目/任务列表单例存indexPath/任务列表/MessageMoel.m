//
//  MessageMoel.m
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "MessageMoel.h"

@implementation MessageMoel

+ (instancetype)shareInstance{
    
    static MessageMoel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        model = [[[self class]alloc]init];
    });
    
    return model;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.taskArray = [aDecoder decodeObjectForKey:@"taskArray"];
        self.indexPathl = [aDecoder decodeObjectForKey:@"indexPathl"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.taskArray  forKey:@"taskArray"];
    [aCoder encodeObject:self.indexPathl  forKey:@"indexPathl"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
