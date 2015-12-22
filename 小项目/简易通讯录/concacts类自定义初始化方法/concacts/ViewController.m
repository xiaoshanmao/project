//
//  ViewController.m
//  concacts
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "Concact.h"
@interface ViewController ()
{
    NSMutableArray *_concactsArray;
    NSString *_concactsPath;
    NSUInteger index;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *wechatTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    _concactsArray = [NSMutableArray array];
    _concactsPath = @"Users/apple/Desktop/concact.plist";
    //页面出来之前加载所有的联系人
    [self loadConcacts];
    //默认显示的一个
    [self displayContact:[_concactsArray firstObject]];
    if ([_concactsArray firstObject]) {
        index = 0;
    }else{
        index = NSNotFound;
    }
}


- (IBAction)saveButtonDIdClicked:(id)sender {
    Concact *concact = [Concact new];
    concact.name = _nameTextField.text;
    concact.gender = _genderTextField.text;
    concact.company = _companyTextField.text;
    concact.occupation = _positionTextField.text;
    concact.phone = _phoneTextField.text;
    concact.email = _emailTextField.text;
    concact.wechat = _wechatTextField.text;
    [_concactsArray addObject:concact];
    //同步数据
    [self updateContactArray];
    index = [_concactsArray count];
    _stateTextField.text = @"保存成功";
    _nameTextField.text = @"";
    _genderTextField.text = @"";
    _companyTextField.text = @"";
    _positionTextField.text = @"";
    _phoneTextField.text = @"";
    _emailTextField.text = @"";
    _wechatTextField.text = @"";
}


- (IBAction)openButtonCliked:(id)sender {
    if (_nameTextField.text)
    {
       for (Concact *tmp in _concactsArray )
       {
           if (tmp.name == _nameTextField.text)
           {
               _genderTextField.text = tmp.gender;
               _companyTextField.text = tmp.company;
               _positionTextField.text = tmp.occupation;
               _phoneTextField.text = tmp.phone;
               _emailTextField.text = tmp.email;
               _wechatTextField.text = tmp.wechat;
               index = [_concactsArray indexOfObject:tmp];
           }
       }
    }else
    {
        _stateTextField.text = @"没有这个联系人";
    }
}


- (IBAction)preButtonClicked:(id)sender {
    if (index == NSNotFound ) {
        _stateTextField.text = @"没有联系人";
        return;
    }
    if (index == 0) {
       _stateTextField.text = @"已经是第一个联系人";
        return;
    }
    Concact *concact = [_concactsArray objectAtIndex:index - 1];
    [self displayContact:concact];
    index--;
    
}


- (IBAction)nextButtonCliked:(id)sender {
    if (index == NSNotFound ) {
        _stateTextField.text = @"没有联系人";
        return;
    }
    if (index == [_concactsArray count] - 1) {
        _stateTextField.text = @"已经是最后一个联系人";
        return;
    }
    Concact *concact = [_concactsArray objectAtIndex:index + 1];
    [self displayContact:concact];
    index++;
}


- (IBAction)deleteButtonClicked:(id)sender {
    if (index == NSNotFound ) {
        _stateTextField.text = @"没有联系人可以删除";
        return;
    }
    [_concactsArray removeObjectAtIndex:index];
    NSUInteger count = [_concactsArray count];
    if (count == 0) {
        _nameTextField.text = @"";
        _genderTextField.text = @"";
        _companyTextField.text = @"";
        _positionTextField.text = @"";
        _phoneTextField.text = @"";
        _emailTextField.text = @"";
        _wechatTextField.text = @"";
        _stateTextField.text = @"空了";
    }else{
    //删除的是最后一个元素
    if (index == count ) {
        index--;
        Concact *concact = [_concactsArray objectAtIndex:index];
        [self displayContact:concact];
    }else
    {
        Concact *concact = [_concactsArray objectAtIndex:index];
        [self displayContact:concact];
    }
    }
    [self updateContactArray];
}

//
- (void)displayContact: (Concact *)contact
{
    if (contact != nil) {
        _nameTextField.text = contact.name;
        _genderTextField.text = contact.gender;
        _companyTextField.text = contact.company;
        _positionTextField.text = contact.occupation;
        _phoneTextField.text = contact.phone;
        _emailTextField.text = contact.email;
        _wechatTextField.text = contact.wechat;
    }
}


- (void)loadConcacts
{
    
    NSMutableDictionary *allDic = [NSMutableDictionary dictionaryWithContentsOfFile:_concactsPath];
    for (NSString *key in [allDic allKeys]) {
        NSMutableDictionary *tmpDic = [allDic objectForKey:key];
        Concact *contact = [[Concact alloc] initWithDict:tmpDic];
        //下面添加到实例变量的联系人数组中
        [_concactsArray addObject:contact];
    }
}


- (void)updateContactArray
{
    //用一个字典来装个人信息的字典，key为名字value为一个个人信息的字典。
    NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
    for (Concact *tmp in _concactsArray )
    {
       NSMutableDictionary *singeDic = [NSMutableDictionary dictionary];
       //下面把该单个对象转换过来的字典加到总的字典对象中
       singeDic = [tmp WithConcact:tmp];
      [allDic setObject:singeDic forKey:tmp.name];
    }
    [allDic writeToFile:_concactsPath atomically:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
