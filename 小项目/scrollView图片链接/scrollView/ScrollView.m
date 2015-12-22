//
//  ScrollView.m
//  scrollView
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ScrollView.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface ScrollView()<UIScrollViewDelegate>
{
    CGSize _size;
    NSMutableArray *_viewsArray;
    UIImageView *_beforeView;
    UIImageView *_currentView;
    UIImageView *_laterView;
    void(^tempBlc)(NSInteger a);
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
            [_viewsArray addObject:view];
        }
        
        self.contentSize = CGSizeMake(_size.width *3, _size.height);
        self.delegate = self;
        self.pagingEnabled = YES;
        [self setContentOffset:CGPointMake(_size.width, 0) animated:YES];
        
         _beforeView = _viewsArray[0];
         _currentView = _viewsArray[1];
         _laterView = _viewsArray[2];
    }
    return self;
}

- (void)demoFunc:(void(^)(NSInteger a))blc{
    
    tempBlc = ^(NSInteger a){
        
        blc(a);
    };
}

- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"end scrolling...");
    
    
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
    
//    _beforeView.image = [UIImage imageNamed:_imageArray[beforeIndex]];
//    _currentView.image = [UIImage imageNamed:_imageArray[currentIndex]];
//    _laterView.image = [UIImage imageNamed:_imageArray[laterIndex]];
    
    [_beforeView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[beforeIndex]]];
    [_currentView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[currentIndex]]];
    [_laterView setImageWithURL:[NSURL URLWithString:(NSString *) _stringArray[laterIndex]]];
    
    [self setContentOffset:CGPointMake(_size.width, 0) animated:NO];
    
    if (tempBlc) {
        
        tempBlc(currentIndex);
    }
}
@end
