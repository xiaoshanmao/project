//
//  ViewController.m
//  buDing —1
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "titleview.h"
#import "TitleView1.h"
#import "HeadView.h"
#import "UIViewController+MMDrawerController.h"
#import "ScrollView.h"
#import "Masonry.h"
#import "CustomCollectionViewCell.h"
#import "animation.h"
#import "UIKit+AFNetworking.h"
#import "CustomLayout.h"
#import "AFNetworking.h"
#import "NetworkManager.h"
#import "APIs.h"
#import "YYCategryModel.h"
#import "dataManager.h"

@interface ViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CustomLayoutDelegate,NetworkManagerDelegate,dataDelegate>
{
    UIScrollView *_srollView;
    CGSize _size;
    NSMutableArray *_viewsArray;
    NSInteger _currentIndex;
    TitleView1 *_view;
    UICollectionView *_collectionView;
    NSMutableArray *_animationArray;
    dataManager *_dManager;
    NSArray *_dataSource;
    YYCategryModel *_categoryModel;
    ScrollView *_scroll;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _currentIndex = 0 ;
    self.view.backgroundColor = [UIColor whiteColor];
    
   //------------------------大的srollView------------------------
    _size = self.view.frame.size;
    _srollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _size.width, _size.height)];
    [self.view addSubview:_srollView];
    _srollView.backgroundColor = [UIColor redColor];
    _srollView.contentSize = CGSizeMake(_size.width*2,0);
    _srollView.pagingEnabled = YES;
    _srollView.delegate = self;
    //弹力
    _srollView.bounces = NO;
    
    
    //------------------------分类和推荐的两个view------------------------
    UIView *demoView = [[UIView alloc] initWithFrame:self.view.bounds];
    [_srollView addSubview:demoView];
    demoView.backgroundColor = [UIColor orangeColor];
    
    
    UIView *demoView1 = [[UIView alloc] initWithFrame:CGRectMake(_size.width, 0, _size.width, _size.height)];
    demoView1.backgroundColor = [UIColor redColor];
    [_srollView addSubview:demoView1];
    
    
     //------------------------导航的自定义的分类和推荐------------------------
    _view = [[TitleView1 alloc] initWithFrame:CGRectMake(80, 0, 120, 44)];
    self.navigationItem.titleView = _view;
    self.delegatel = (id)_view;
    
    
    [_view whichButtonClicked:^(UIButton *button, NSInteger index) {
        
        NSLog(@"%@", NSStringFromCGPoint(_srollView.contentOffset));
       NSLog(@"%ld",(long)index);
        if (index == 1) {
            
            [_srollView setContentOffset:CGPointMake(0, -64) animated:YES];
        }else{
            
            [_srollView setContentOffset:CGPointMake(_size.width, -64) animated:YES];
        }
    }];
    
    
    //------------------------推荐view上的ScrollView------------------------
    _scroll = [[ScrollView alloc]initWithFrame:CGRectMake(0, 64, _size.width, 200)];
    _scroll.backgroundColor = [UIColor grayColor];

    _scroll.contentSize = CGSizeMake(_size.width*3, 200);

    self.automaticallyAdjustsScrollViewInsets = NO;
    _scroll.frame = CGRectMake(0, 0, _size.width, 200);
    
    
    [demoView addSubview:_scroll];
//    [_scroll setContentOffset:CGPointMake(_size.width, 0) animated:YES];
    //写了定时器自己在滑动contentOffset一直在变化self.mm_drawerController.pan.enabled = NO;一直是no.
//    [scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
 
    
    _scroll.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
//    //------------------------推荐view上的ScrollView的pageContol------------------------
//    UIPageControl *pageContol = [[UIPageControl alloc] initWithFrame:CGRectMake(140, 160, 100, 40)];
//    [demoView addSubview:pageContol];
//    pageContol.numberOfPages = [_scroll.stringArray count];
//    pageContol.pageIndicatorTintColor = [UIColor blackColor];
//    pageContol.currentPageIndicatorTintColor = [UIColor whiteColor];
//    pageContol.currentPage = 0;
//    //布局不受父视图的影响
//   //pageContol.translatesAutoresizingMaskIntoConstraints = NO;
//   //pageContol.tag = 1001;
    
    
    //----------------------两个srollView的pan手势开关--------------------------
    //设定两个srollView的Target变化调用方法实现pan手势的开关。
    [_srollView.panGestureRecognizer addTarget:self action:@selector(didPanScrollViewYes)];
    [_scroll.panGestureRecognizer addTarget:self action:@selector(didPanScrollViewNo)];
//    
//    [_scroll demoFunc:^(NSInteger a) {
//        
//        pageContol.currentPage = a;
//    }];
    
    //----------------------导航的right--------------------------
    UIImage *rightImage = [UIImage imageNamed:@"global_header_btn_search_normal"];
    rightImage = [rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(rightImageDidCliked)];
    
    
    HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self.view addSubview:headView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:headView];
    [headView whichButtonClicked:^(UIButton *button) {
        
        if (self.mm_drawerController.openSide == MMDrawerSideLeft) {
            
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            
        }else{
            
            [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
              //self.mm_drawerController.pan.enabled = YES;
            }];
        }
    }];
    self.mm_drawerController.pan.delegate = self;
    
   //----------------------推荐的collectionView----------------------
    
    CustomLayout *flowLayout = [[CustomLayout alloc] init];
    flowLayout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [demoView addSubview:_collectionView];
    _animationArray = [NSMutableArray array];
    
   // [self loadData1];
    //----------------------推荐的collectionView的网络请求----------------------
    NetworkManager *manager = [NetworkManager new];
    _dManager = [dataManager new];
    manager.delegate = (id)_dManager;
    _dManager.delegate = self;
    [manager networkManagerWithURL:[NSString stringWithFormat:@"%@%@",kHomePath,kCategory] andPara:nil];
    
    [manager networkManagerWithURL:[NSString stringWithFormat:@"%@%@",kHomePath,kRecommended]andPara:nil];
}

- (void)upDate:(NSMutableArray *)array{
    
    _dataSource = array;
    [_collectionView reloadData];
    
}

//srollView跑马的代理方法。
- (void)upDate1:(NSMutableArray *)array{
    
     _scroll.stringArray = array;
}

- (CGFloat)collectionCellHeightWithIndexPath:(NSIndexPath *)indexPath{
    
    _categoryModel = _dataSource[indexPath.item];
    CGFloat  height= (CGFloat)(_categoryModel.image.height.floatValue/_categoryModel.image.height.floatValue )* 150;
    return  height;
}
- (void)didPanScrollViewNo{
    
    self.mm_drawerController.pan.enabled = NO;
}

- (void)didPanScrollViewYes{
    
    self.mm_drawerController.pan.enabled = YES;
}

- (void)configWithScrollView:(UIScrollView *)scrollView{
    
    CGSize size = self.view.frame.size;
    if(scrollView.contentOffset.x == size.width){
        
        _currentIndex = 1;
        [self.delegatel indexDelegate:_currentIndex];
        self.mm_drawerController.pan.enabled = NO;
        scrollView.bounces = YES;
        
    }else if (scrollView.contentOffset.x == 0){
        
        _currentIndex = 0;
        [self.delegatel indexDelegate:_currentIndex];
        self.mm_drawerController.pan.enabled = YES;
        scrollView.bounces = NO;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(_currentIndex == 1 && self.mm_drawerController.pan.enabled == YES){
        
        self.mm_drawerController.pan.enabled = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
     [self configWithScrollView:scrollView];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
     [self configWithScrollView:scrollView];
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (_currentIndex == 1) {
       
     self.mm_drawerController.pan.enabled = NO;
    }
}

//
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

- (void)rightImageDidCliked{
    
    
}

#pragma mark-collectionView的代理方法


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    _categoryModel = _dataSource[indexPath.item];
    cell.centerText = _categoryModel.name;
    cell.limage = _categoryModel.image.url;

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
