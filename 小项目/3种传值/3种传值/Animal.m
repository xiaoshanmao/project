//
//  Animal.m
//  3种传值
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "Animal.h"

@implementation Animal
{
    void(^tmpBlc)(int a);
}
static int a;

- (void)launch{
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tempAdd) userInfo:nil repeats:YES];
}
- (void)tempAdd{
    
    a++;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notikey" object:@(a)];
    
    
    if ([self.delegate respondsToSelector:@selector(getTheValueFromDelegate:)]) {

        [self.delegate getTheValueFromDelegate:a];
    
         //判断外界是否实存在tmpblc这个方法，如果存在说明调用了- (void)numFromBlc:(void(^)(int a))blc这个方法。
    }

    if (tmpBlc) {
        
        tmpBlc(a);
    }
    
    if (self.block) {
        
        self.block(a);
    }
}

- (void)numFromBlo:(void(^)(int))blc{
    
    tmpBlc = ^(int a){
        
        blc(a);
    };
}
@end
