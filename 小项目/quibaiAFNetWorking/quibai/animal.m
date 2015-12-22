//
//  animal.m
//  quibai
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "animal.h"

@implementation animal

void(^tmpblc)(int a);
static int num;

- (void)launch{
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tempAdd) userInfo:nil repeats:YES];
    
}

- (void)tempAdd
{
    num++;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notikey" object:@(num)];
    if ([self.delegate respondsToSelector:@selector(getNum:)]) {
        
       [self.delegate getNum:num];
    }
    
    //判断外界是否实存在tmpblc这个方法，如果存在说明调用了- (void)numFromBlc:(void(^)(int a))blc这个方法。
    if (tmpblc) {
        
       tmpblc(num);
    }
 
    if (self.block) {
        
        self.block(num);
    }
    
}

- (void)numFromBlc:(void(^)(int a))blc{
    
    tmpblc = ^ (int a){
        blc(a);
    };
}

@end
