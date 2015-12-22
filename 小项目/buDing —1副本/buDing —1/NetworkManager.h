//
//  NetworkManager.h
//  buDing —1
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 TabBarController. All rights reserved.

#import <Foundation/Foundation.h>
@class NetworkManager;

@protocol NetworkManagerDelegate <NSObject>

@optional
- (void)theReponseResultWith:(NetworkManager *)manager andRespondsObj:(id)responseObj andError:(NSError *)error;
- (void)theReponseResultWithRunHorse:(NetworkManager *)manager andRespondsObj:(id)responseObj andError:(NSError *)error;
@end

@interface NetworkManager : NSObject
@property (nonatomic,strong,readonly)NSURL *url;
@property (nonatomic,weak)id<NetworkManagerDelegate>delegate;
- (void)networkManagerWithURL:(NSString *)urlString andPara:(NSDictionary *)para;
@end
