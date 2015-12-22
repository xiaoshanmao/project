//
//  CustomLayout.h
//  flowLayout--石工布局
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol flowLayoutDelegate <NSObject>

- (CGFloat)flowLayoutDelegate:(NSIndexPath *)indexPath;

@end

@interface CustomLayout : UICollectionViewFlowLayout

@property (nonatomic,weak)id<flowLayoutDelegate>delegate;
@property (nonatomic,assign)CGFloat itemSpace;
@property (nonatomic,assign)CGFloat itemWidth;
@end
