//
//  notes.h
//  Godson
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface notes : NSObject<NSCoding>

@property (nonatomic,copy)NSString *titleField;
@property (nonatomic,copy)NSString *contentField;

@end
