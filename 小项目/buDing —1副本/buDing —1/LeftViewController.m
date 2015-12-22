//
//  LeftViewController.m
//  buDing —1
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "LeftViewController.h"
#import "customTableViewCell.h"
#import "LeftUserInfoView.h"
#import "Masonry.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tabelView;
    NSArray *_leftImageArray;
    NSArray *_leftTitleArray;
    
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _leftImageArray = @[@"side_menu_icon_history",@"side_menu_icon_cache",@"side_menu_icon_statistics",@"side_menu_icon_promotor"];
    _leftTitleArray = @[@"追番纪录",@"离线缓存",@"布丁统计",@"布丁娘送周边"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
   
    [self creatView];
    
    [self creatButton];
    
   // LeftUserInfoView *infoView = [[LeftUserInfoView alloc] initWithFrame:]
  
}
-(void)creatTableView{
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.separatorStyle = NO;
    [_tabelView registerClass:[customTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tabelView.rowHeight = 60;
    _tabelView.scrollEnabled = NO;
    
    [_tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}

//_tabelView设置头部和尾部view
- (void)creatView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, self.view.frame.size.height)];
    _tabelView.backgroundView = imageView;
    imageView.image = [UIImage imageNamed:@"BGI_1.jpg"];
    
    
    LeftUserInfoView *infoView = [[LeftUserInfoView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
    
    infoView.avatarImage = [UIImage imageNamed:@"1_1.jpg"];
    infoView.fanCount = 18;
    infoView.followCount = 30;
    infoView.nicknameLabel.text = @"小🐱";
    infoView.isLogin = YES;
    
    [infoView addAvatarTarget:self action:@selector(userInfoAvatarClicked:)
    forControlEvents:UIControlEventTouchUpInside];
    [infoView addFollowerTarget:self action:@selector(userInfoFollowerClicked:)
               forControlEvents:UIControlEventTouchUpInside];
    [infoView addFansTarget:self action:@selector(userInfoFansClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    
    
    
   // UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
    infoView.backgroundColor = [UIColor clearColor];
    _tabelView.tableHeaderView = infoView;
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
    footView.backgroundColor = [UIColor clearColor];
    _tabelView.tableFooterView = footView;
}

- (void)userInfoAvatarClicked:(id)sender{
    
    NSLog(@"图像被点击");
}

- (void)userInfoFollowerClicked:(id)sender{
    
   NSLog(@"关注被点击");
}

- (void)userInfoFansClicked:(id)sender{
    
    NSLog(@"粉丝被点击");
}
- (void)creatButton{
    
    //settingButton
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"side_menu_icon_setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingButton];
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view).offset(20);
        make.size.equalTo(MASBoxValue(CGSizeMake(80, 40)));
    }];
    
    
    //notification button
    UIButton *notificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [notificationButton setTitle:@"通知" forState:UIControlStateNormal];
    [notificationButton setImage:[UIImage imageNamed:@"side_menu_icon_notification"] forState:UIControlStateNormal];
    [notificationButton addTarget:self action:@selector(notificationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notificationButton];
    [notificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(settingButton);
        make.size.equalTo(settingButton);
        
    }];
}

- (void)notificationButtonClicked:(UIButton *)button{
    
    
}

- (void)settingButtonClicked:(UIButton *)button{
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

       
    cell.centerText = _leftTitleArray[indexPath.row];
    UIImage *img = [UIImage imageNamed:_leftImageArray[indexPath.row]];
    cell.limage = img;
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
