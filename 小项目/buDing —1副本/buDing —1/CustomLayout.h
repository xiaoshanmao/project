//
//  CustomLayout.h
//  buDing —1
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomLayoutDelegate <NSObject>

@required
- (CGFloat)collectionCellHeightWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface CustomLayout : UICollectionViewLayout
@property (nonatomic,weak)id<CustomLayoutDelegate>delegate;

@property (nonatomic,assign) CGFloat proportion;

@end
