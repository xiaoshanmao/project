//
//  notes.m
//  Godson
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "notes.h"

@implementation notes

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.titleField forKey:@"titleField"];
    [aCoder encodeObject:self.contentField forKey:@"contentField"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _contentField = [aDecoder decodeObjectForKey:@"titleField"];
        _titleField = [aDecoder decodeObjectForKey:@"titleField"];
    }
    return self;
}
@end
