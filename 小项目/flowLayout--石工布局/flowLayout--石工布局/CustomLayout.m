//
//  CustomLayout.m
//  flowLayout--石工布局
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "CustomLayout.h"
@interface CustomLayout()
{
    CGFloat _itemSpace;
    CGFloat _itemWidth;
    NSMutableArray *_totalHightColum;
    
     NSInteger _totalColumn;
     NSMutableArray *_attrs;
}
@end
@implementation CustomLayout

-(instancetype)init{
    
    if (self = [super init]) {
        
//        _itemSpace = 20;
//        _itemWidth = 60;
        _totalHightColum = [NSMutableArray array];
        _attrs = [NSMutableArray array];
    }
    return self;
}
//收集attribute
-(void)prepareLayout{
    
    [super prepareLayout];
    
    _totalColumn = (CGFloat)(self.collectionView .frame.size.width - _itemSpace)/(_itemSpace + _itemWidth);
    _totalColumn = (NSInteger)floorf(_totalColumn);
    
    _itemSpace = (self.collectionView .frame.size.width - _itemWidth*_totalColumn)/(_totalColumn + 1);
    
    for (int i = 0; i < _totalColumn; i++) {
        
         NSMutableArray *recodeY = [NSMutableArray array];
        [_totalHightColum addObject:recodeY];
    }
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    for (int i = 0; i<sections; i++) {
        
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j<items; j++) {
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:j inSection:i];
            NSInteger currentIndex = j%_totalColumn;
            
            NSMutableArray *tempRecodeY = _totalHightColum[currentIndex];
            NSNumber *y = [tempRecodeY lastObject];
            CGFloat position_y = y.floatValue + _itemSpace;
            CGFloat position_x = (currentIndex + 1)*_itemSpace + currentIndex*_itemWidth;
            
            CGFloat itemHeight = [self.delegate flowLayoutDelegate:indexpath];
            [tempRecodeY addObject:@(position_y + itemHeight)];
            
            UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
            attr.frame = CGRectMake(position_x, position_y, _itemWidth, itemHeight);
            [_attrs addObject:attr];
        }
    }
   
}


//返回attribute
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSLog(@"%@",_attrs);
    return _attrs;
    //NSLog(@"%@",_attrs);
}

- (CGSize)collectionViewContentSize{
    
     NSMutableArray *tempY = [NSMutableArray array];
    
    for (NSMutableArray *array in _totalHightColum) {
        
        NSNumber *num = [array lastObject];
        [tempY addObject:num];
    }
    
    NSNumber *tempNuber = [tempY firstObject];
    
    CGFloat maxheight = tempNuber.floatValue;
    
    for (NSNumber *num in tempY) {
        
        if (maxheight < num.floatValue) {
            
            maxheight = num.floatValue;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, maxheight);
}

@end
