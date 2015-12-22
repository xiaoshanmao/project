//
//  joke.h
//  JSONjoke
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface joke : NSObject

@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *jokeContent;
@property (nonatomic,copy)NSString *click_count;
@property (nonatomic,copy)NSString *iconPath;

@end
