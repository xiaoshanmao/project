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
    NSDictionary *_respDict;
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
    //只需要执行一次。
   // [self saveDict];
  
}
- (IBAction)showButtonClicked:(UIButton *)sender {
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/apple/Desktop/dict.plist"];

    NSDictionary *dict1 = [dict valueForKey:_showTextField.text];
     _todayWeather.text = [dict1 valueForKey:@"wendu"];
     _hightWeather.text = [dict1 valueForKey:@"high"];
     _lowWeather.text = [dict1 valueForKey:@"low"];
   
    }

- (void)saveDict
{
    NSString *string = [NSString stringWithContentsOfFile:_allstrPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    NSMutableDictionary *allDict = [NSMutableDictionary dictionary];
    for (NSString *str in array) {
        
        NSArray *array1 = [str componentsSeparatedByString:@"="];
        _weatherPath = [NSString stringWithFormat:@"%@%@",_basis,[array1 firstObject]];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_weatherPath]];
        
        _respDict = [NSDictionary dictionaryWithXMLData:data];
       // NSLog(@"$%@",_respDict);
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (_respDict[@"wendu"]) {
          [dict setObject:_respDict[@"wendu"] forKey:@"wendu"];
        }
        
        NSDictionary *forecastDict = _respDict[@"forecast"];
        NSArray *weatherArray = forecastDict[@"weather"];
        NSDictionary *tomorrowDict = weatherArray[2];
        if (tomorrowDict[@"high"]) {
            
         [dict setObject:tomorrowDict[@"high"] forKey:@"high"];
        }
        if (tomorrowDict[@"low"]) {
            
           [dict setObject:tomorrowDict[@"low"] forKey:@"low"];
        }
        if (_respDict[@"city"]) {
            
          [allDict setObject:dict forKey:_respDict[@"city"]];
        }
    }
    [NSKeyedArchiver archiveRootObject:allDict toFile:@"/Users/apple/Desktop/dict.plist"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
