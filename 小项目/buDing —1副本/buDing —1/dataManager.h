//
//  dataManager.h
//  buDing —1
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 TabBarController. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@protocol dataDelegate <NSObject>

- (void)upDate:(NSMutableArray *)array;
- (void)upDate1:(NSMutableArray *)array;
@end
@interface dataManager : NSObject

- (void)theReponseResultWith:(NetworkManager *)manager andRespondsObj:(id)responseObj andError:(NSError *)error;
@property (nonatomic,strong)id<dataDelegate>delegate;
@end