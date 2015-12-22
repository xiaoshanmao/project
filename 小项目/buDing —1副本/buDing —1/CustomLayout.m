//
//  CustomLayout.m
//  buDing —1
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "CustomLayout.h"

@interface CustomLayout ()
{
    CGFloat _itemWidth;
    CGFloat _itemSpace;
    
    NSInteger _totalColumn;
    NSMutableArray *_recodesPosition_y;
    NSMutableArray *_attrs;
}
@end

@implementation CustomLayout

#if 1

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        _itemWidth = 150;
        _itemSpace = 1;
        
        _recodesPosition_y = [NSMutableArray array];
        _attrs = [NSMutableArray array];
    }
    
    return self;
}

- (void)prepareLayout{
    
    [super prepareLayout];
    
    _totalColumn = (CGFloat)(self.collectionView.frame.size.width - _itemSpace) / (_itemSpace + _itemWidth);
    
    _totalColumn = (NSInteger)floorf(_totalColumn);
    
    _itemSpace = (self.collectionView.frame.size.width - _totalColumn * _itemWidth)/(_totalColumn + 1);
    
    for (int temp = 0; temp<_totalColumn; temp++) {
        
        NSMutableArray *recodeY = [NSMutableArray array];
        [_recodesPosition_y addObject:recodeY];
    }
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    for (int i = 0; i<sections; i++) {
        
        //一开始网络数据没有加载totalItems为0
        NSInteger totalItems = [self.collectionView numberOfItemsInSection:i];
        
        for (int j = 0; j<totalItems; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            
            NSInteger currentIndex = j % _totalColumn;
            
            NSMutableArray *tempRecodeY = _recodesPosition_y[currentIndex];
            NSNumber *numOfY = [tempRecodeY lastObject];
            
            CGFloat position_y = numOfY.floatValue + _itemSpace;
            CGFloat position_x = (currentIndex + 1)*_itemSpace + currentIndex*_itemWidth;
            
            CGFloat itemHeight = [self.delegate collectionCellHeightWithIndexPath:indexPath];
            
            [tempRecodeY addObject:@(position_y+itemHeight)];
            
            UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attr.frame = CGRectMake(position_x, position_y, _itemWidth, itemHeight);
            
            [_attrs addObject:attr];
        }
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return _attrs;
}
//

- (CGSize)collectionViewContentSize{
    
    
    if (![_attrs count]) {
        
        NSLog(@"%lu",(unsigned long)[_attrs count]);
        return CGSizeZero;
    }
    
    NSMutableArray *tempY = [NSMutableArray array];
    
    for (NSMutableArray *tempArray in _recodesPosition_y) {
        
        NSNumber *numOfY = [tempArray lastObject];
        
        //一开始因为网络异步导致数组里面多加了两个空元素
        if (numOfY == nil) {
            
        }else{
            
        [tempY addObject:numOfY];
        }
    }
    
    NSNumber *tempNumOfY = tempY[0];
    CGFloat maxheight = tempNumOfY.floatValue;
    
    for (NSNumber *tempNum in tempY) {
        
        if(maxheight < tempNum.floatValue){
            
            maxheight = tempNum.floatValue;
        }
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, maxheight + 300);
}


#endif

@end
