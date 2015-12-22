//
//  ScrollView.m
//  buDing —1
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ScrollView.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "Masonry.h"

@interface ScrollView()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    CGSize _size;
    NSMutableArray *_viewsArray;
    UIImageView *_beforeView;
    UIImageView *_currentView;
    UIImageView *_laterView;
    void(^tempBlc)(NSInteger a);
    UIPageControl *_pageControl;
}
@end
@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _viewsArray = [NSMutableArray array];
        _imageArray = [NSMutableArray array];
        _stringArray = [NSMutableArray array];
        _size = self.frame.size;
        for (int i = 0; i < 3; i++) {
            
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(i*_size.width, 0, _size.width, _size.height)];
            [self addSubview:view];
            [view addSubview:_pageControl];
            [_viewsArray addObject:view];
        }
        self.contentSize = CGSizeMake(_size.width *3, _size.height);
        
        
        //写这个会滚动调用- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView方法，此时_stringArray为空。
        //[self setContentOffset:CGPointMake(_size.width, 0) animated:YES];
        //写在调用代理的方法之前，因为这个时候没有设置代理不会调用代理的方法
        [self setContentOffset:CGPointMake(_size.width, 0) animated:YES];

        self.delegate = self;
        self.pagingEnabled = YES;
        
        _beforeView = _viewsArray[0];
        _currentView = _viewsArray[1];
        _laterView = _viewsArray[2];


        NSTimer *_timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(demoRunTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
   // return self;
    return self;
}


- (void)didMoveToSuperview{
    
    _pageControl = [UIPageControl new];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    //_pageControl.numberOfPages = [_stringArray count];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 1;
    [self.superview addSubview:_pageControl];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@10);
        make.width.equalTo(@100);
    }];
}

- (void)demoFunc:(void(^)(NSInteger a))blc{
    
    tempBlc = ^(NSInteger a){
        
        blc(a);
    };
}

- (void)demoRunTimer{
    
    [self setContentOffset:CGPointMake(_size.width*2, 0) animated:YES];
}

- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
    _pageControl.numberOfPages = [_stringArray count];
    
    if ([_imageArray count] < 3)
    {
        _currentView.image = [UIImage imageNamed:[_imageArray firstObject]];
        self.scrollEnabled = NO;
    }
    _beforeView.image = [UIImage imageNamed:_imageArray[0]];
    _currentView.image = [UIImage imageNamed:_imageArray[1]];
    _laterView.image = [UIImage imageNamed:_imageArray[2]];

}

- (void)setStringArray:(NSArray *)stringArray{
    
    _stringArray = stringArray;
    if ([stringArray count] < 2) {
        
        self.scrollEnabled = NO;
        [_currentView setImageWithURL:[NSURL URLWithString:(NSString *)[_stringArray firstObject]]];
    }

    [_beforeView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[0]]];
    [_currentView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[1]]];
    [_laterView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[2]]];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    static NSInteger currentIndex = 1;
    NSInteger beforeIndex = 0, laterIndex = 0;
    
    if ([_stringArray count] == 0) {
        
        return;
    }
    
    if(scrollView.contentOffset.x == 2 *_size.width){//到右
        
        currentIndex++;
        if(currentIndex >= [_stringArray count]){
            
            currentIndex = 0;
        }
    }
    
    if(scrollView.contentOffset.x == 0){//到左
        
        currentIndex--;
        if(currentIndex < 0){
            
            currentIndex = [_stringArray count] - 1;
        }
    }
    
    if(currentIndex == 0){
        
        beforeIndex = [_stringArray count] - 1;
        laterIndex = 1;
    }else if (currentIndex == ([_stringArray count] -1)){
        
        beforeIndex = currentIndex - 1;
        laterIndex = 0;
    }else{
        
        beforeIndex = currentIndex - 1;
        laterIndex = currentIndex + 1;
    }


    [_beforeView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[beforeIndex]]];
    [_currentView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[currentIndex]]];
    [_laterView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[laterIndex]]];

    [self setContentOffset:CGPointMake(_size.width, 0) animated:NO];
    
    
    _pageControl.currentPage = currentIndex;
//    if (tempBlc) {
//        
//        tempBlc(currentIndex);
//    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    static NSInteger currentIndex = 1;
    NSInteger beforeIndex = 0, laterIndex = 0;
    
    
    if(scrollView.contentOffset.x == 2 *_size.width){//到右
        
        currentIndex++;
        if(currentIndex >= [_stringArray count]){
            
            currentIndex = 0;
        }
    }
    
    if(scrollView.contentOffset.x == 0){//到左
        
        currentIndex--;
        if(currentIndex < 0){
            
            currentIndex = [_stringArray count] - 1;
        }
    }
    
    if(currentIndex == 0){
        
        beforeIndex = [_stringArray count] - 1;
        laterIndex = 1;
    }else if (currentIndex == ([_stringArray count] -1)){
        
        beforeIndex = currentIndex - 1;
        laterIndex = 0;
    }else{
        
        beforeIndex = currentIndex - 1;
        laterIndex = currentIndex + 1;
    }
    NSLog(@"beforeIndex:%ld  currentIndex:%ld laterIndex:%ld", (long)beforeIndex,(long)currentIndex,(long)laterIndex);

    [_beforeView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[beforeIndex]]];

    [_currentView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[currentIndex]]];
    [_laterView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[laterIndex]]];

    [self setContentOffset:CGPointMake(_size.width, 0) animated:NO];
    
    if (tempBlc) {
        
        tempBlc(currentIndex);
    }
    
   
}
@end
