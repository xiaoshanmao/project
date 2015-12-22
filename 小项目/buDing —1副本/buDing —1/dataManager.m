//
//  dataManager.m
//  buDing —1
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "dataManager.h"
#import "NetworkManager.h"
#import "YYModel.h"
#import "YYCategryModel.h"
@interface dataManager()<NetworkManagerDelegate>
{
    NSArray *_dataSouce;
    NSMutableArray *_dataArray;
    //NSMutableArray *_dataArray1;
}
@end
@implementation dataManager

- (void)theReponseResultWith:(NetworkManager *)manager andRespondsObj:(id)responseObj andError:(NSError *)error{
    
    if(error){
        
        NSLog(@"error:%@",error);
        return;
    }
    
    if ([responseObj isKindOfClass:[NSArray class]]) {
        
         _dataSouce = (NSArray *)responseObj;
        
         _dataArray = [NSMutableArray array];
    
    for (NSDictionary *tempDict in _dataSouce) {
        
        YYCategryModel  *categryModel = [YYCategryModel yy_modelWithJSON:tempDict];
        
        [_dataArray addObject:categryModel];
        
    }
    
    [self.delegate upDate:_dataArray];
   
    }else{
        
        _dataArray = [NSMutableArray array];
        NSArray *array = responseObj[@"featured_banner"];
        for (NSDictionary *dict in array) {
            
            [_dataArray addObject:dict[@"imageUrl"]];
        }
        [self.delegate upDate1:_dataArray];
    }
}



@end
