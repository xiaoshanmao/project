//
//  TaskR.m
//  任务列表
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "TaskR.h"

@implementation TaskR

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.color = [aDecoder decodeObjectForKey:@"color"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content= [aDecoder decodeObjectForKey:@"content"];
        self.time= [aDecoder decodeObjectForKey:@"time"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.color forKey:@"color"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.title forKey:@"title"];
     }

@end
