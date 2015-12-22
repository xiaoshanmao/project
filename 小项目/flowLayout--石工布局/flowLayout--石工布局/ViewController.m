//
//  ViewController.m
//  flowLayout--石工布局
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "ViewController.h"
#import "CustomLayout.h"
#import "CustomCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,flowLayoutDelegate>
{
    UICollectionView *_collectionView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(50, 60);
    flowLayout.minimumInteritemSpacing = 4;
    flowLayout.minimumLineSpacing = 4;
#if 0
    //因为UIcollectionview和UItableView是继承的UIScrollView，所以UIcollectionview有UIScrollView一些特征。可以就行分页设置
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0;
#endif
    
#if 0
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    flowLayout.minimumInteritemSpacing = 4;
    flowLayout.minimumLineSpacing = 4;
#endif
#if 0
    CustomLayout  *customLayout = [CustomLayout new];
    customLayout.itemSpace = 20;
    customLayout.itemWidth = 80;
    customLayout.delegate = self;
#endif
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    //[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"]
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
   // [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headcell"];
    [self.view addSubview:_collectionView];
    
    
   // _collectionView.pagingEnabled = YES;
    //flowLayout.headerReferenceSize = CGSizeMake(0, 50);
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    [scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headcell" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor redColor];
        return headView;
    }
    return nil;
}

//去除第一部分的headView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeMake(0, 0);
    }else{
        
        return CGSizeMake(0, 50);
    }
}

- (CGFloat)flowLayoutDelegate:(NSIndexPath *)indexPath{
    
    return arc4random() % 100 + 100;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return 4;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 90;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //cell.backgroundColor = [self randoColor];
    cell.centerText = @"";
    
    return cell;
}

- (UIColor *)randoColor{
    
    CGFloat red_value = arc4random() % 255 + 1;
    CGFloat green_value = arc4random() % 255 + 1;
    CGFloat blue_value = arc4random() % 255 + 1;
    
    UIColor *color = [UIColor colorWithRed:red_value/255 green:green_value/255 blue:blue_value/255 alpha:1];
    
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
