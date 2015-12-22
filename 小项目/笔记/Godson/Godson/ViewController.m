//
//  ViewController.m
//  Godson
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *_titlePath;
    NSString *_contentPath;
    NSMutableArray *_titleArray;
    NSMutableArray *_contentArray;
    NSString *str;
    NSString *strB;
    int i;
    int j;
}

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *allTitleTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    strB = @"";
    [self getFilePaths];
    [self loadFile];
    _allTitleTextField.text = [self allTitle];
}

//显示所有的标题并且在前面显示为第几篇。
- (NSString *)allTitle
{
        i = 1;
        for (NSString *strA in _titleArray)
        {
            str = [NSString stringWithFormat:@"(%d):%@    ",i,strA];
            strB = [strB stringByAppendingString:str];
            i ++;
        }
    return strB;
}

- (void)getFilePaths
{
    _titlePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/title.txt"];
    _contentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/content.txt"];
}

- (void)loadFile
{
    _titleArray = [NSMutableArray arrayWithContentsOfFile:_titlePath];
    _contentArray = [NSMutableArray arrayWithContentsOfFile:_contentPath];
}

- (IBAction)saveButtonClicked:(id)sender
{
    if (_titleArray == nil ) {
        _titleArray = [NSMutableArray array];
    }
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    if (_titleTextField.text && _contentTextView.text) {
        if ([_titleArray indexOfObject:_titleTextField.text] == NSNotFound) {
    
        [_titleArray addObject:_titleTextField.text];
        [_titleArray writeToFile:_titlePath atomically:YES];
            
        }else
        {
            //当保存的标题已经存在主动生成标题。
            if (j >= 1)
            {
                j++;
                _titleTextField.text = [NSString stringWithFormat:@"file%d",j];
                [_titleArray addObject:_titleTextField.text];
                [_titleArray writeToFile:_titlePath atomically:YES];
            }else
            {
            j = 1;
            _titleTextField.text = [NSString stringWithFormat:@"file%d",j];
            [_titleArray addObject:_titleTextField.text];
            [_titleArray writeToFile:_titlePath atomically:YES];
            j++;
            }
        }
        [_contentArray addObject:_contentTextView.text];
        [_contentArray writeToFile:_contentPath atomically:YES];
    }else
    {
        NSLog(@"请输入内容");
    }
}

- (IBAction)openButtonClicked:(id)sender
{
    if (_titleTextField.text)
    {
        NSInteger index = [_titleArray indexOfObject:_titleTextField.text];
        
        if (index == NSNotFound) {
            NSLog(@"没有该笔记");
        }else
        {
            _contentTextView.text = [_contentArray objectAtIndex:index];
        }
    }
}

- (IBAction)nextButtonClicked:(id)sender
{
    NSInteger index = [_titleArray indexOfObject:_titleTextField.text];
    if (index == [_titleArray count] - 1) {
      _contentTextView.text = [_contentArray objectAtIndex:0];
      _titleTextField.text = [_titleArray objectAtIndex:0];
    }else
    {
      _contentTextView.text = [_contentArray objectAtIndex:index + 1];
      _titleTextField.text = [_titleArray objectAtIndex:index + 1];
    }
}

- (IBAction)ptrButtonClicked:(id)sender
{
   NSInteger index = [_titleArray indexOfObject:_titleTextField.text];
    if (index == 0) {
      _contentTextView.text = [_contentArray objectAtIndex:[_titleArray count] - 1];
       _titleTextField.text = [_titleArray objectAtIndex:[_titleArray count] - 1];
    }else
    {
      _contentTextView.text = [_contentArray objectAtIndex:index - 1];
      _titleTextField.text = [_titleArray objectAtIndex:index - 1];
    }
}

- (IBAction)deletButtonClicked:(id)sender
{
   NSInteger index = [_titleArray indexOfObject:_titleTextField.text];
    [_titleArray removeObjectAtIndex:index];
    [_contentArray removeObjectAtIndex:index];
    
    if (index == [_titleArray count]) {
        _contentTextView.text = [_contentArray objectAtIndex:0];
        _titleTextField.text = [_titleArray objectAtIndex:0];
    }else
    {
        _contentTextView.text = [_contentArray objectAtIndex:index];
        _titleTextField.text = [_titleArray objectAtIndex:index];
    }
    
    [_contentArray writeToFile:_contentPath atomically:YES];
    [_titleArray writeToFile:_titlePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
