//
//  ViewController.m
//  Godson
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "ViewController.h"
#import "notes.h"
@interface ViewController ()
{
    NSMutableArray *_contentsArray;
    NSString *_contentPath;
    NSUInteger index;
}
@property (weak, nonatomic) IBOutlet UITextField *tiTleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


@end

@implementation ViewController
//实现每一个笔记为一个单独的文件可以用NSFileManager来实现对文件的操作。（创建文件可以用NSFileManager也可以用write）
- (void)viewDidLoad {
    [super viewDidLoad];
    //_contentsArray = [NSMutableArray array];
    index = 0;
    _contentPath = @"Users/apple/Desktop/note.plist";
    if (![NSKeyedUnarchiver unarchiveObjectWithFile:_contentPath]) {
         _contentsArray = [NSMutableArray array];
        [NSKeyedArchiver archiveRootObject:_contentsArray toFile:_contentPath];
    }
}




- (IBAction)saveButtonClicked:(id)sender
{
    if (_tiTleTextField.text && _contentTextView.text) {
        _contentsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_contentPath];
        notes *note = [notes new];
        note.titleField = _tiTleTextField.text;
        note.contentField = _contentTextView.text;
        for (notes *note1 in _contentsArray) {
            if ([note.titleField isEqualToString:note1.titleField])
            {
                NSLog(@"该文件已经存在");
            }
            else
            {
                [_contentsArray addObject:note];
                [NSKeyedArchiver archiveRootObject:_contentsArray toFile:_contentPath];
            }
        }
        _tiTleTextField.text = @"";
        _contentTextView.text = @"";
    }
}

- (IBAction)openButtonClicked:(id)sender
{
    if (_tiTleTextField.text) {
      _contentsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_contentPath];
    }
    for (notes *note in _contentsArray) {
        if ([_tiTleTextField.text isEqualToString:note.titleField]) {
            _contentTextView.text = note.contentField;
            index = [_contentsArray indexOfObject:note];
        }
    }
}

- (IBAction)nextButtonClicked:(id)sender
{
    notes *note;
    if (index == [_contentsArray count] - 1)
    {
        note  = [_contentsArray objectAtIndex:0];
        _tiTleTextField.text = note.titleField;
        _contentTextView.text = note.contentField;
        index = 0;
    }else
    {
    note  = [_contentsArray objectAtIndex:index + 1];
    _tiTleTextField.text = note.titleField;
    _contentTextView.text = note.contentField;
        index++;
    }
}

- (IBAction)ptrButtonClicked:(id)sender
{
    notes *note;
    if (index == 0 )
    {
        note = [_contentsArray objectAtIndex:[_contentsArray count] - 1];
        _tiTleTextField.text = note.titleField;
        _contentTextView.text = note.contentField;
        index = [_contentsArray count] - 1;
    }else
    {
      note = [_contentsArray objectAtIndex:index - 1];
        _tiTleTextField.text = note.titleField;
        _contentTextView.text = note.contentField;
        index--;
    }
}

- (IBAction)deletButtonClicked:(id)sender
{
    notes *note;
    if ([_contentsArray count] == 1) {
      [_contentsArray removeObjectAtIndex:index];
        _tiTleTextField.text = @"";
        _contentTextView.text = @"";
    }else
    {
    [_contentsArray removeObjectAtIndex:index];
    if (index == [_contentsArray count] -1) {
        index = 0;
        note = [_contentsArray objectAtIndex:0];
        _tiTleTextField.text = note.titleField;
        _contentTextView.text = note.contentField;
    }else
    {
        note = [_contentsArray objectAtIndex:index ];
        _tiTleTextField.text = note.titleField;
        _contentTextView.text = note.contentField;
    }
    
    [NSKeyedArchiver archiveRootObject:_contentsArray toFile:_contentPath];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
