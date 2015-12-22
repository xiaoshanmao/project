//
//  ViewController.m
//  calender
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 TabBarController. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()
{
    CGFloat _xsetOff;
    CGFloat _ysetOff;//整体偏移量
    CGFloat _xSpace;
    CGFloat _ySpace;//间距
    CGFloat _dayWidth;
    CGFloat _dayHeight;//矩形长宽
    NSMutableArray * _labelsArray;
    NSString *_string;
    NSDate *_date;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpConfig];
    //[self today];
    [self displayCalenderWithDate:[NSDate date]];
    _date = [NSDate date];

}
- (void)today
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componrnts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
    NSString *string = [NSString stringWithFormat:@"今天是%ld年%ld月%ld日",componrnts.year,componrnts.month,componrnts.day];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"ccc";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    _label.text = [NSString stringWithFormat:@"%@%@",string,dateString];
    NSLog(@"%@",_label.text);
}

-(void)setUpConfig
{
    //获取整个屏幕的size
    CGSize screenSize=[UIScreen mainScreen].bounds.size;
    _xsetOff=0;
    _ysetOff=100;
    _ySpace=2;
    _xSpace=2;
    _dayWidth=(screenSize.width-_xSpace*8)/7;
    _dayHeight=100;
}


//label的方法。
-(UILabel *)createLabelWithFrame:(CGRect)frame andText:(NSString*)text
{
    UILabel *label=[UILabel new];
    label.numberOfLines=0;//不限制显示行数
    label.textAlignment=NSTextAlignmentCenter;//文本居中
    label.backgroundColor=[UIColor colorWithRed:0xdd/255.0 green:0x48/255.0 blue:0x14/255.0 alpha:0.6];
    label.textColor=[UIColor whiteColor];
    label.tag = 1001;
    label.frame=frame;
    label.text=text;
    return label;
}


//根据月初日期和该月的第几天得到星期几
-(NSString *)getWeekFromDate:(NSUInteger)days sinceDate:(NSDate *)startDate
{
    NSDate * date=[NSDate dateWithTimeInterval:3600*24*(days) sinceDate:startDate];
    NSDateFormatter * dateFormatter=[NSDateFormatter new];
    //格式化输出星期几的形式。
    dateFormatter.dateFormat=@"ccc";
    //把字符串转化为date.
    NSString * weekday=[dateFormatter stringFromDate:date];
    //把两个字符串连接起来。
    //月初从一号开始比如我们给一个日子27号我们想算的是27号是星期几但是事实上算的是28号是星期几。
    _label.text = [NSString stringWithFormat:@"%@%@",_string,weekday];
    return [NSString stringWithFormat:@"%zu\n%@",days+1,weekday];
    
}



//显示任意给定日期对应的日历
-(void)displayCalenderWithDate:(NSDate *)date
{
    NSDate *startDateOfMonth;
    NSUInteger daysOfMonth ;
    [self startDate:&startDateOfMonth andDay:&daysOfMonth  ofMonthWithDate:date];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componrnts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    _string = [NSString stringWithFormat:@"今天是%ld年%ld月%ld日",componrnts.year,componrnts.month,componrnts.day];
    NSLog(@"%lu",daysOfMonth);
    
    //下面得到起始日和当月总天数，结果输出到上面2个变量。
    for (int week=0, dayOfMonth = 0; week < 5;week++ ) {
        for (int dayOfWeek=0; (dayOfWeek<7)&&(dayOfMonth< daysOfMonth); dayOfWeek++,dayOfMonth++)
        {
            CGFloat x=dayOfWeek*_dayWidth+(dayOfWeek+1)*_xSpace + _xsetOff;
            CGFloat y=week*_dayHeight+(week+1)*_ySpace+_ysetOff;
            CGRect frame=CGRectMake(x, y, _dayWidth,_dayHeight );
            NSString * text=[self getWeekFromDate:dayOfMonth sinceDate:startDateOfMonth];
            
            UILabel *lable;
            lable =[self createLabelWithFrame:frame andText:text];
            [self.view addSubview:lable];
            [_labelsArray addObject:lable];
        }
    }
}


//根据任意一天计算当月的起始日以及当月一共有多少天。
//通过参数传指针输出结果
//当我们需要多个返回值时我们可以用指针来获取地址然后改变所对应的值
-(void)startDate:(NSDate **)startDateOfMonth andDay:(NSUInteger *)day ofMonthWithDate:(NSDate *)date
{
    NSDate * startDate;
    NSTimeInterval secondsOfMonth;
    NSCalendar *calender=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //当前系统的时间。
    [calender setTimeZone:[NSTimeZone systemTimeZone]];
    //用日历对象计算当月起始日和当月一共有多少秒。
    [calender rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:&secondsOfMonth forDate:date];
    //修正起始日期的时区。
    NSUInteger dayss=secondsOfMonth/(3600*24);
    *day = dayss;
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    NSInteger interval=[zone secondsFromGMTForDate:*startDateOfMonth];
    *startDateOfMonth = [startDate dateByAddingTimeInterval:interval];
}


- (IBAction)preMonth:(id)sender {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componrnts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:_date];
    
    NSDateComponents *componrnts1 = [[NSDateComponents alloc] init];
    
    if(componrnts.month == 1) {
        
        componrnts1.year = componrnts.year - 1;
        componrnts1.month = 12;
        componrnts1.day = 1;
        _date = [calendar dateFromComponents:componrnts1];
        [self clearView];
        [self displayCalenderWithDate:_date];
    }else
    {
        componrnts1.year = componrnts.year;
        componrnts1.month = componrnts.month - 1;
        componrnts1.day = 1;
        _date = [calendar dateFromComponents:componrnts1];
        [self clearView];
        [self displayCalenderWithDate:_date];
    }
    
}
- (IBAction)nextMonth:(id)sender {
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componrnts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:_date];
    
    NSDateComponents *componrnts1 = [[NSDateComponents alloc] init];
    
    if(componrnts.month == 12) {
        
        componrnts1.year = componrnts.year + 1;
        componrnts1.month = 1;
        componrnts1.day = 1;
        _date = [calendar dateFromComponents:componrnts1];
        [self clearView];
        [self displayCalenderWithDate:_date];
    }else
    {
        componrnts1.year = componrnts.year;
        componrnts1.month = componrnts.month + 1;
        componrnts1.day = 1;
        _date = [calendar dateFromComponents:componrnts1];
        [self clearView];
        [self displayCalenderWithDate:_date];
    }
}

- (void)clearView
{
    NSArray *views = [self.view subviews];
    for (UIView *view in views) {
        if (view.tag == 1001) {
            
            [view removeFromSuperview];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
