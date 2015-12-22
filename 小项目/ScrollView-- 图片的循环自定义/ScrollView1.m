//
//  ScrollView1.m
//  ScrollView
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ScrollView1.h"
@interface ScrollView1()<UIScrollViewDelegate>
{
    CGSize _size;
    NSMutableArray *_viewsArray;
}
@end
@implementation ScrollView1

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
         _imageArray = [NSMutableArray array];
         _size = self.frame.size;
         for (int i = 0; i<=3; i++) {
             
                self.contentSize = CGSizeMake(_size.width *3, 200);
                UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(i*_size.width, 0, _size.width, 200)];
                view.image = [UIImage imageNamed:_imageArray[i]];
                [self addSubview:view];
                [_viewsArray addObject:view];
            }
        self.delegate = self;
        self.pagingEnabled = YES;
        [self setContentOffset:CGPointMake(_size.width, 0) animated:YES];
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArrayl{
    
    _imageArray = imageArrayl;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"end scrolling...");
    
    
    static NSInteger currentIndex = 1;
    NSInteger beforeIndex = 0, laterIndex = 0;
    
    UIImageView *beforeView = _viewsArray[0];
    UIImageView *currentView = _viewsArray[1];
    UIImageView *laterView = _viewsArray[2];
    //滑动后得到当前的索引值.
    if (scrollView.contentOffset.x == 2 *_size.width) {
        
        currentIndex++;
        if (currentIndex >= [_imageArray count]) {
            
            currentIndex = 0;
        }
    }
    if (scrollView.contentOffset.x == 0) {
        
        currentIndex--;
        if (currentIndex <= 0) {
            
            currentIndex = [_imageArray count] - 1;
        }
    }
    //根据当前的索引值来确定前一个和后一个的索引值
    if (currentIndex == 0) {
        
        beforeIndex = [_imageArray count] - 1;
        laterIndex = 1;
    }else if( currentIndex == [_imageArray count] - 1){
        
        beforeIndex = 1;
        laterIndex = [_imageArray count] - 1;
    }else{
        
        beforeIndex = currentIndex - 1;
        laterIndex = currentIndex + 1;
    }
    
    beforeView.image = [UIImage imageNamed:_imageArray[beforeIndex]];;
    currentView.image = [UIImage imageNamed:_imageArray[currentIndex]];;
    laterView.image = [UIImage imageNamed:_imageArray[laterIndex]];;
    //一滑动还是显示当前的view,不过在滑动的时候已经把3个view的颜色改变了
    [self setContentOffset:CGPointMake(_size.width, 0) animated:NO];
}
@end
