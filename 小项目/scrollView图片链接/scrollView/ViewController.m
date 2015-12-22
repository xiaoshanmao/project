//
//  ViewController.m
//  scrollView
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "ViewController.h"
#import "ScrollView.h"
@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    CGSize _size;
    NSArray *_color;
    NSMutableArray *_viewsArray;
    NSArray *_imaArray;
    NSTimer *_timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_imaArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",];
    
    ScrollView *scroll = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    //scroll.imageArray = _imaArray;
   scroll.stringArray = @[@"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",@"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg",@"http://pic.nipic.com/2007-11-09/200711912230489_2.jpg",@"http://anquanweb.com/uploads/userup/913/1322O9102-2596.jpg",@"http://a2.att.hudong.com/38/59/300001054794129041591416974.jpg",@"http://pic25.nipic.com/20121126/8305779_171431388000_2.jpg"];
    
    [self.view addSubview:scroll];

//    _scrollView.pagingEnabled = YES;
//    //程序起来显示第二个view
//    [_scrollView setContentOffset:CGPointMake(_size.width, 0) animated:YES];
//    self.automaticallyAdjustsScrollViewInsets = YES;
    scroll.pagingEnabled = YES;
    [scroll setContentOffset:CGPointMake(_size.width, 0) animated:YES];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    UIPageControl *pageContol = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 150, 100, 40)];
    [self.view addSubview:pageContol];
    pageContol.numberOfPages = 6;
    pageContol.pageIndicatorTintColor = [UIColor orangeColor];
    pageContol.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageContol.currentPage = 0;
    
    
    [scroll demoFunc:^(NSInteger a) {
        
         pageContol.currentPage = a;
    }];
    
    //_timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:YES];
}


#if 0
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
        if (currentIndex >= [_imaArray count]) {
            
            currentIndex = 0;
        }
    }
    if (scrollView.contentOffset.x == 0) {
        
        currentIndex--;
        if (currentIndex <= 0) {
            
            currentIndex = [_imaArray count] - 1;
        }
    }
    //根据当前的索引值来确定前一个和后一个的索引值
    if (currentIndex == 0) {
        
        beforeIndex = [_imaArray count] - 1;
        laterIndex = 1;
    }else if( currentIndex == [_imaArray count] - 1){
        
        beforeIndex = 1;
        laterIndex = [_imaArray count] - 1;
    }else{
        
        beforeIndex = currentIndex - 1;
        laterIndex = currentIndex + 1;
    }
    
    beforeView.image = [UIImage imageNamed:_imaArray[beforeIndex]];
    currentView.image = [UIImage imageNamed:_imaArray[currentIndex]];
    laterView.image = [UIImage imageNamed:_imaArray[laterIndex]];
    
    //一滑动还是显示当前的view,不过在滑动的时候已经把3个view的颜色改变了
    [_scrollView setContentOffset:CGPointMake(_size.width, 0) animated:NO];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"代码end animating....");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[_scrollView setContentOffset:CGPointMake(-100, 0) animated:YES];
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //
    //    CGFloat endOffSet_x = targetContentOffset->x;
    //    CGFloat num = roundf(endOffSet_x / _size.width);
    //    CGFloat finaOffSet_x = num*_size.width;
    //
    //    targetContentOffset->x = finaOffSet_x;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#endif
@end
