//
//  ViewController.m
//  weather
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "XMLDictionary.h"
@interface ViewController ()
{
    NSString *_basis;
    NSString *_weatherPath;
    NSString *_allstrPath;
}
@property (weak, nonatomic) IBOutlet UITextField *showTextField;
@property (weak, nonatomic) IBOutlet UITextField *todayWeather;
@property (weak, nonatomic) IBOutlet UITextField *hightWeather;
@property (weak, nonatomic) IBOutlet UITextField *lowWeather;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allstrPath = @"/Users/apple/Desktop/weather.txt";
    _basis = @"http://wthrcdn.etouch.cn/WeatherApi?citykey=";
  
}
- (IBAction)showButtonClicked:(UIButton *)sender {
    
    NSString *string = [NSString stringWithContentsOfFile:_allstrPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    for (NSString *str in array) {
        
        NSArray *array1 = [str componentsSeparatedByString:@"="];
         NSLog(@"%@",_showTextField.text);
        NSLog(@"%@",[array1 lastObject]);
          _weatherPath = [NSString stringWithFormat:@"%@%@",_basis,[array1 firstObject]];
        if ([[array1 lastObject] isEqualToString:_showTextField.text ]) {
            NSLog(@"%@",_showTextField.text);
            _weatherPath = [NSString stringWithFormat:@"%@%@",_basis,[array1 firstObject]];
            NSLog(@"111%@",_weatherPath);
        }
    }
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_weatherPath]];
    NSLog(@"%@",data);
    NSDictionary *respDict = [NSDictionary dictionaryWithXMLData:data];
    NSLog(@"@@@%@",respDict);
    NSLog(@"%@",_weatherPath);
    _todayWeather.text = respDict[@"wendu"];
    
    NSDictionary *forecastDict = respDict[@"forecast"];
    NSArray *weatherArray = forecastDict[@"weather"];
    NSDictionary *tomorrowDict = weatherArray[2];
    _hightWeather.text = tomorrowDict[@"high"];
    _lowWeather.text = tomorrowDict[@"low"];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
