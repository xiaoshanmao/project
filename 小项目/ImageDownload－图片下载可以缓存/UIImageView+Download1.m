//
//  UIImageView+Download1.m
//  ImageDownload
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "UIImageView+Download1.h"

@implementation UIImageView (Download1)


+ (void)initialize{
    
    [super initialize];
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/cache.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cachePath]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [NSKeyedArchiver archiveRootObject:dict toFile:cachePath];
    }
}

- (void)custom_setImageWithURL:(NSURL *)url{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
#if 0
        NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/cache.plist"];
        NSMutableDictionary *tempDict = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
        
        if(tempDict[url.absoluteString]){
            
            NSData *imageData = (NSData *)tempDict[url.absoluteString];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.image = [UIImage imageWithData:imageData];
                
            });
            
        }else{
            
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            [tempDict setObject:imageData forKey:url.absoluteString];
            [NSKeyedArchiver archiveRootObject:tempDict toFile:cachePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.image = [UIImage imageWithData:imageData];
            });
            
        }
        
#endif
        
        
#if 1
        //系统的这个方法defaultSessionConfiguration这个参数具有缓存功能
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *seesion = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDataTask *task = [seesion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(!error){
                
                UIImage *tempImage = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.image = tempImage;
                });
            }
        }];
        
        [task resume];
#endif
    });
    
}
@end


