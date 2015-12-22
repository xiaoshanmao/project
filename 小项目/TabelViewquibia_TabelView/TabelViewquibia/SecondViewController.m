//
//  SecondViewController.m
//  TabelViewquibia
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    UITextView *TextView;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    TextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 100,  300, 400)];
    self.view.backgroundColor = [UIColor whiteColor];
    TextView.font = [UIFont systemFontOfSize:20];
    TextView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:TextView];
    
}


- (void)messageSend:(NSString *)string{
    
    TextView.text = string;
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
