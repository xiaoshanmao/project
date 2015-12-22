//
//  ViewController.m
//  SQLite
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "FMDB.h"
int callback(void *context, int count, char **columnText,char **columnName);

@interface ViewController ()
{
    sqlite3 *_db;
    FMDatabase *_dataBase;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //------------------第三方框架--------------
    
   NSString *path = @"/Users/apple/Desktop/dataBase1.sqlite";
    _dataBase = [FMDatabase databaseWithPath:path];
    
    if (![_dataBase open]) {
        
        NSLog(@"打开失败");
        return;
    }
#if 0
    [_dataBase executeUpdate:@"create table if not exists Person(name text, age interger)"];
    [_dataBase executeUpdate:@"insert into Person (name ,age) values ('张三',22)"];
    [_dataBase executeUpdate:@"insert into Person (name ,age) values(?,?)",@"李四",@25];
    [_dataBase executeUpdateWithFormat:@"insert into Person (name ,age) values(%@,%@)",@"王五",@30];
    
#endif
    
    [_dataBase executeUpdate:@"delete from Person where name = ?",@"张三"];
    
    [_dataBase executeUpdate:@"delete from Person where rowid = 1"];
    
    FMResultSet *resultSet = [_dataBase executeQuery:@"select * from Person"];
    while ([resultSet next]) {
        
        NSString *name = [resultSet stringForColumn:@"name"];
        NSInteger age = [resultSet intForColumn:@"age"];
        NSLog(@"name = %@",name);
        NSLog(@"age = %ld",age);
        
    }
    
    
    [_dataBase executeUpdate:@"update Person set age = 60 where name = '王五'"];
    [_dataBase close];
    
//------------------c语言方法--------------
#if 0
    NSString *dbName = @"School.db";
    NSString *path = [NSHomeDirectory()
                      stringByAppendingFormat:@"/Documents/%@", dbName];
    NSLog(@"%@",path);
    
   // NSString *path = @"/Users/apple/Desktop/dataBase.sqlite";
    _db = NULL;
    //如果数据库不存在，自动创建并打开
    //数据库必须在可以读写的目录下
    //基本上所有的数据库操作都用返回值表示成功。
    int result = sqlite3_open(path.UTF8String, &_db);
    
    if (result == SQLITE_OK) {
     
        NSLog(@"打开成功");
    }
    
    NSString *sql = @"create table if not exists Person (name text, age integer)";
    if (_db) {
        
        
        char *errormsg = NULL;
        //倒数第二个参数作为callback的第一个参数
        int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errormsg);
        if (result == SQLITE_OK) {
            
            NSLog(@"创建成功");
        }
    }
    
    NSString *sql3 = @"insert into Person ('name','age') values ('%@',%@)";
    sql3 = [NSString stringWithFormat:sql3, @"如花",@18];
    
    if (_db) {
        
        char *errorMsg = NULL;
        int result = sqlite3_exec(_db, sql3.UTF8String, NULL, NULL, &errorMsg);
        
        if (result == SQLITE_OK) {
            
            NSLog(@"插入成功");
        }
    }
    
    NSString *sql4 = @"select * from Person";
    if (_db) {
        
        char *errorMsg = NULL;
        int result = sqlite3_exec(_db, sql4.UTF8String, callback, NULL, &errorMsg);
        if (result == SQLITE_OK) {
            
            NSLog(@"查询成功");
        }
    }
    
    sqlite3_close(_db);
}

//回调函数
//第二个参数为获取到的数据的列数
//第三个参数为数据的文本形式（一行数据）
//第四个参数为对应的字段名
int callback(void *context, int count, char **columnText,char **columnName){
    
    
    for (int i = 0; i<count; i++) {
        
        NSString *columtext = [NSString stringWithUTF8String:columnText[i]];
         NSLog(@"%@,%s",columtext,columnName[i]);
    }
    return 0;

#endif

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
