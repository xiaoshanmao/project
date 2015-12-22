//
//  ViewController.m
//  OpenbuildingRegistration
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "FMDB.h"
#import "AppDelegate.h"
#import "Guests.h"

@interface ViewController ()
{
    FMDatabase  *_dataBase;
    NSManagedObjectContext *_context;
    NSEntityDescription *_entity;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ganderTextField;
@property (weak, nonatomic) IBOutlet UITextField *IDTextField;
@property (weak, nonatomic) IBOutlet UITextField *RoomnumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    _context = appDelegate.managedObjectContext;
    _entity = [NSEntityDescription entityForName:@"Guests" inManagedObjectContext:_context];
   
}

- (IBAction)saveButtoncCliked:(id)sender {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Guests"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"idd = %@",_IDTextField.text];
    NSArray *result = [_context executeFetchRequest:request error:nil];
    if (result.count == 0) {
        
        Guests *guest = [[Guests alloc] initWithEntity:_entity insertIntoManagedObjectContext:_context];
        guest.idd = _IDTextField.text;
        guest.name = _nameTextField.text;
        guest.gander = _ganderTextField.text;
        guest.homeId = _RoomnumberTextField.text;
        _informationLabel.text = @"保存成功";
        
    }else{
        
        _informationLabel.text = @"该身份证已经存在";
    }
}
- (IBAction)selectButtonCliked:(id)sender {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Guests"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"idd = %@",_IDTextField.text];
    NSArray *result = [_context executeFetchRequest:request error:nil];
    
    if (result.count == 1) {
        
        for (Guests *tempGuest in result) {
          
        _nameTextField.text = tempGuest.name;
        _IDTextField.text = tempGuest.idd;
        _RoomnumberTextField.text = tempGuest.homeId;
        _ganderTextField.text = tempGuest.gander;
        _informationLabel.text = @"查询成功";
      }
    }else{
        
       _informationLabel.text = @"该客人不存在";
    }
      
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
