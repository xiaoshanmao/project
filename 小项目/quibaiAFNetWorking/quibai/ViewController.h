//
//  ViewController.h
//  quibai
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "getNum.h"
void(^blc)(NSData *a);
@interface ViewController : UIViewController<getNum>

//- (NSData *)demoFun:(void(^)(NSData *a))blc;



@end

