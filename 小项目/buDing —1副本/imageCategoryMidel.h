//
//  imageCategoryMidel.h
//  buDing —1
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface imageCategoryModel : NSObject

//必须和字典里的key名字相同。
@property (nonatomic,strong)NSNumber *height;
@property (nonatomic,strong)NSNumber *width;
@property (nonatomic,copy)NSString *url;

@end
