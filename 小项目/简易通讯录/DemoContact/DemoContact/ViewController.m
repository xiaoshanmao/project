//
//  ViewController.m
//  DemoContact
//
//  Created by frankfan on 15/10/29.
//  Copyright © 2015年 frankfan. All rights reserved.
//

#import "ViewController.h"

#define kName @"name"
#define kSex @"sex"
#define kComp @"company"
#define kNameCode @"nameCode"

@interface ViewController ()
{

    NSMutableArray *_infos;
    NSString *_path;
    NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

@end

@implementation ViewController
//思路：：直接是两层的关系，就是数组里面放字典，把字典储存起来用的时候直接用字典的方法（比如[tempDict[kName]isEqualToString:self.nameTextField.text]）来取值和判断。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/info.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_path]){
    
        _infos = [NSMutableArray array];
        [NSKeyedArchiver archiveRootObject:_infos toFile:_path];
    }
    
    _currentIndex = 0;
    _infos = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
 
}


#pragma mark - saveButtonClicked
- (IBAction)saveButtonClicked:(UIButton *)sender {
    
    if(self.nameTextField.text.length){

        BOOL beThere = NO;
        NSMutableDictionary *targetDict;
        for (NSMutableDictionary *tempDict in _infos) {
            
            if([tempDict[kName]isEqualToString:self.nameTextField.text]){
                
                beThere = YES;
                targetDict = tempDict;
                //注意用break,提高程序的效率。找到了就不需要在继续遍历
                break;
            }
        }
        
        if(beThere){
        
            NSInteger nameCode = [targetDict[kNameCode]integerValue]+1;
            NSString *changedName = [NSString stringWithFormat:@"%@(%ld)",self.nameTextField.text,nameCode];
            
              //在字典里面新加一个键值对用于判断是该联系人是非应该存在。
            targetDict[kNameCode] = @(nameCode);
            NSMutableDictionary *mutiDict = [NSMutableDictionary dictionary];
            
            mutiDict[kName] = changedName;
            mutiDict[kSex] = self.sexTextField.text;
            mutiDict[kComp] = self.companyTextField.text;
            mutiDict[kNameCode] = @(nameCode);
            
            [_infos addObject:mutiDict];
            [NSKeyedArchiver archiveRootObject:_infos toFile:_path];
            
            [self clearTheInput];
            
        }else{
        
            NSMutableDictionary *mutiDict = [NSMutableDictionary dictionary];
            
            mutiDict[kName] = self.nameTextField.text;
            mutiDict[kSex] = self.sexTextField.text;
            mutiDict[kComp] = self.companyTextField.text;
            mutiDict[kNameCode] = @0;
            
            [_infos addObject:mutiDict];
            [NSKeyedArchiver archiveRootObject:_infos toFile:_path];
            
            [self clearTheInput];
        }
    }
}

#pragma mark - showButtonClicked
- (IBAction)showButtonClicked:(UIButton *)sender {
    
    NSMutableDictionary *dict;
    if(self.nameTextField.text.length){
    
        for (NSMutableDictionary *tempDict in _infos) {
            
            if([tempDict[kName]isEqualToString:self.nameTextField.text]){
            
                dict = tempDict;
                break;
            }
        }
        _currentIndex = [_infos indexOfObject:dict];
        
        self.nameTextField.text = dict[kName];
        self.sexTextField.text = dict[kSex];
        self.companyTextField.text = dict[kComp];
    }
    
}

#pragma mark - deleteButtonClicked
- (IBAction)deleteButtonCliked:(UIButton *)sender {
    
    if(self.nameTextField.text.length){
    
        NSMutableDictionary *dict;
        for (NSMutableDictionary *tempDict in _infos) {
            
            if([tempDict[kName]isEqualToString:self.nameTextField.text]){
                
                dict = tempDict;
                break;
            }
        }
        [_infos removeObject:dict];
        [NSKeyedArchiver archiveRootObject:_infos toFile:_path];
        
        [self clearTheInput];
    }
    
    
}

#pragma mark - preButtonCliked
- (IBAction)preButtonDidCliked:(id)sender {
    if ([_infos count]) {
        _currentIndex--;
        if (_currentIndex < 0) {
            _currentIndex = [_infos count] - 1;
        }
        NSMutableDictionary *mutiDict = _infos[_currentIndex];
        
        self.nameTextField.text = mutiDict[kName];
        self.sexTextField.text = mutiDict[kSex];
        self.companyTextField.text = mutiDict[kComp];
    }
}

#pragma mark - nextButtonClicked
- (IBAction)nextButtonClicked:(UIButton *)sender {
    
    if([_infos count]){
    
        _currentIndex++;
        
        if(_currentIndex >= [_infos count]){
        
            _currentIndex = 0;
        }
        
        NSMutableDictionary *mutiDict = _infos[_currentIndex];
        
        self.nameTextField.text = mutiDict[kName];
        self.sexTextField.text = mutiDict[kSex];
        self.companyTextField.text = mutiDict[kComp];
    }
    
}


- (void)clearTheInput{
    
    self.nameTextField.text = nil;
    self.sexTextField.text = nil;
    self.companyTextField.text = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
