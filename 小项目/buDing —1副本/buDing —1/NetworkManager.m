//
//  NetworkManager.m
//  buDing —1
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"

@implementation NetworkManager

- (void)networkManagerWithURL:(NSString *)urlString andPara:(NSDictionary *)para{
    
     _url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", nil];
    
    manager.requestSerializer.timeoutInterval = 15;
//    NSString *userName;
//    NSString *passWord;
//    [manager POST:@"..接口" parameters:@{@"name":userName,@"word":passWord,@"begin":@0 ,@"legth":@9} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//        
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//       
//        
//    }];
    [manager GET:urlString parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if([self.delegate respondsToSelector:@selector(theReponseResultWith:andRespondsObj:andError:)]){
            
            [self.delegate theReponseResultWith:self andRespondsObj:responseObject andError:nil];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        if([self.delegate respondsToSelector:@selector(theReponseResultWith:andRespondsObj:andError:)]){
            
            [self.delegate theReponseResultWith:self andRespondsObj:nil andError:error];
        }
        
    }];
}
@end
