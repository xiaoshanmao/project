//
//  animal.h
//  quibai
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getNum.h"

typedef void(^tmp)(int a);
@interface animal : NSObject

@property (nonatomic,strong)id<getNum> delegate;
@property (nonatomic,strong)tmp block;

- (void)launch;
- (void)numFromBlc:(void(^)(int a))blc;

@end
