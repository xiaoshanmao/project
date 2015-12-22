//
//  SeconderViewController.m
//  绘画－选色
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "SeconderViewController.h"

@interface SeconderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_color;
}
@end

@implementation SeconderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _color = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style: UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [self randomcolor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    [self.delegate colorDelegate:cell.backgroundColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIColor *)randomcolor
{
    CGFloat red=(arc4random()%256)/255.00;
    
    CGFloat blue=(arc4random()%256)/255.00;
    
    CGFloat green=(arc4random()%256)/255.00;
    
    CGFloat alpha=(arc4random()%256)/255.00;
    
    UIColor * color=[UIColor new];
    
    color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return  color;
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
