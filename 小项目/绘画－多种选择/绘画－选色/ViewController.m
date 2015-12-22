//
//  ViewController.m
//  绘画－选色
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "customView.h"
#import "SeconderViewController.h"
@interface ViewController ()
{
    customView *customview;
    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    UIButton *_button4;
    UIButton *_button5;
    int a;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatButton];
    [self creatButton1];
    [self.delegate buttonWithNumber:0];
     a = 1;
}

- (void)creatButton{
    
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_button1];
    [_button1 setTitle:@"清屏" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_button1 addTarget:self action:@selector(button1DidCliked:) forControlEvents:UIControlEventTouchUpInside ];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_button2];
    [_button2 setTitle:@"选色" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_button2 addTarget:self action:@selector(button2DidCliked:) forControlEvents:UIControlEventTouchUpInside ];
    
    _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_button3];
    [_button3 setTitle:@"橡擦" forState:UIControlStateNormal];
    [_button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button3 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_button3 addTarget:self action:@selector(button3DidCliked:) forControlEvents:UIControlEventTouchUpInside ];
    
    _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_button4];
    [_button4 setTitle:@"🎨" forState:UIControlStateNormal];
    [_button4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button4 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_button4 addTarget:self action:@selector(button4DidCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_button5];
    [_button5 setTitle:@"截图" forState:UIControlStateNormal];
    [_button5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button5 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_button5 addTarget:self action:@selector(button5DidCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *views = @[_button1,_button2,_button3,_button4,_button5];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(@20);
        make.height.equalTo(@40);
    }];
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    
}

- (void)creatButton1{
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.tag = 1005;
    [self.view addSubview:button5];
    [button5 setTitle:@"画圆" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button5 addTarget:self action:@selector(buttonDidCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.tag = 1006;
    [self.view addSubview:button6];
    [button6 setTitle:@"直线" forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button6 addTarget:self action:@selector(buttonDidCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button7= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button7];
    button7.tag = 1007;
    [button7 setTitle:@"矩形" forState:UIControlStateNormal];
    [button7 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button7 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button7 addTarget:self action:@selector(buttonDidCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *views1 = @[button5, button6, button7];
    
    [views1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [views1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
}

- (void)buttonDidCliked:(UIButton *)sender{
    
    if (sender.tag == 1005) {
     
        [self.delegate buttonWithNumber:5];
    }
    if (sender.tag == 1006) {
      
       [self.delegate buttonWithNumber:6];
    }
    if (sender.tag == 1007) {
        
       [self.delegate buttonWithNumber:7];
    }
}

- (void)button1DidCliked:(UIButton *)sender{

    UIView *view = [self.view viewWithTag:1001];
    [view removeFromSuperview];
    a = 1;
    [self.delegate buttonWithNumber:0];
}


- (void)button2DidCliked:(UIButton *)sender{
    
    SeconderViewController *secVC = [SeconderViewController new];
    
    secVC.delegate = (id)customview;
    [self presentViewController:secVC animated:YES completion:^{
        
    }];
    [self.delegate buttonWithNumber:0];
}

- (void)button3DidCliked:(UIButton *)sender{
    
    [self.delegate clearColorDelegate];
    [self.delegate buttonWithNumber:0];
    
}
- (void)button4DidCliked:(UIButton *)sender{

    if (a == 1) {
        
    customview = [[customView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height)];
    self.delegate = (id)customview;
    customview.tag = 1001;
    customview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:customview];
        a = 2;
    }else{
        
        return;
    }
    [self.delegate buttonWithNumber:0];
}

- (void)button5DidCliked:(UIButton *)sender{
    
    _button5.hidden = YES;
    _button4.hidden = YES;
    _button3.hidden = YES;
    _button2.hidden = YES;
    _button1.hidden = YES;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view drawViewHierarchyInRect:self.view.frame afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [imageData writeToFile:@"/Users/apple/desktop/demoImage.jpg" atomically:YES];
    
    UIGraphicsEndImageContext();
    
    _button5.hidden = NO;
    _button4.hidden = NO;
    _button3.hidden = NO;
    _button2.hidden = NO;
    _button1.hidden = NO;
    [self.delegate buttonWithNumber:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
