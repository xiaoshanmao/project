//
//  CustomButton.m
//  DemoOC_58
//
//  Created by frankfan on 15/11/20.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "CustomButton.h"
#import "Masonry.h"
#import "CustomItem.h"

@interface CustomButton ()
{

    CustomItem *_button1;
    CustomItem *_button2;
    
    UIView *_tempFlagView;
    CustomItem *_tempButton;
    
    void (^tempBlc)(NSInteger,UIButton *);
}
@end

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
    
        _button1 = [CustomItem buttonWithType:UIButtonTypeCustom];
        _button1.tag = 1001;
        [self addSubview:_button1];
        
        _button2 = [CustomItem buttonWithType:UIButtonTypeCustom];
        _button2.tag = 1002;
        [self addSubview:_button2];
        
//        _tempFlagView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 30, 30)];
//        _tempFlagView.backgroundColor = [UIColor whiteColor];
       
        
    }
    
    return self;
}


//
- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    CGRect rect = self.frame;
    
    _button1.backgroundColor = [UIColor redColor];
    _button1.frame = CGRectMake(0, 0, rect.size.width*0.5, rect.size.height);
   [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _button2.backgroundColor = [UIColor greenColor];
    _button2.frame = CGRectMake(rect.size.width*0.5, 0, rect.size.width*0.5, rect.size.height);
    [_button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)buttonClicked:(CustomItem *)sender{
 
    _tempButton.hideIt = YES;
    sender.hideIt = NO;
    _tempButton = sender;
    
    if(tempBlc){
    
        tempBlc(sender.tag - 1000,sender);
    }

}


- (void)whichButtonClicked:(void (^)(NSInteger, UIButton *))blc{
    
    tempBlc = ^(NSInteger index,UIButton *button){
    
        blc(index,button);
    };

}
//属性的set方法，可以获得外界先让那一个button上的button小方块显示
- (void)setWhichIndex:(NSInteger)whichIndex{

    if(whichIndex <= 2 && whichIndex >= 1){
        
        NSInteger index = 1000 + whichIndex;
        CustomItem *button = (CustomItem *)[self viewWithTag:index];
        button.hideIt = NO;
       
        _tempButton = button;
    }
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
