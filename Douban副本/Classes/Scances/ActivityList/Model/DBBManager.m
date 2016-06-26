//
//  DBBManager.m
//  Douban
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DBBManager.h"
#import "ArchiverHandle.h"
#import "UserFileHandle.h"

//归档时需要的key
#define kActivityArchiver @"activity"

@interface DBBManager ()
//数据库路径
@property (nonatomic,strong)NSString *databasePath;

@end

@implementation DBBManager


singleton_implementation(DBBManager)

- (NSString *)databasePath {
    if (_databasePath == nil) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _databasePath = [documentPath stringByAppendingPathComponent:@"DBB.sqlite"];
    }
    return _databasePath;
}
//数据库指针
static sqlite3 *db = nil;

//打开数据库
- (void)openDB {
    NSLog(@"%@",self.databasePath);
    int result = sqlite3_open([self.databasePath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        [self createTable];
        
    }else {
        NSLog(@"数据库打开失败");
    }
}
//关闭数据库
- (void)closeDB {
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }else {
        NSLog(@"关闭失败");
    }
    
}
#pragma mark - activity
//创建表
- (void)createTable {
    //c创建表的语句
    //如富哦想存储大型的数据、文件、图片 对象 可以用BLOB类型 （转成data进行存储）
    NSString *createTable = @"create table if not exists ActivityListTable(userName TEXT, ID TEXT, title TEXT, imageUrl TEXT, data BLOB)";
    //执行sql语句
    int result = sqlite3_exec(db, [createTable UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
    
}

//插入
- (void)insertNewActivity:(Activity *)activity {
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    NSString * insertString = @"insert into ActivityListTable(userName,ID,title,imageUrl, data) values (?,?,?,?,?)";
    int result = sqlite3_prepare_v2(db, insertString.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [activity.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [activity.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [activity.image UTF8String], -1, NULL);
        NSString *key = [NSString stringWithFormat:@"%@%@",kActivityArchiver,activity.ID];
        NSData *data = [[ArchiverHandle shareArchiverHandle]dataOfArchiverObject:activity forkey:key];
        //blob类型的绑定
        sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], NULL);
        sqlite3_step(stmt);
        
    }else {
        NSLog(@"插入语句错误 %d",result);
    }
    sqlite3_finalize(stmt);
}
//删除
- (void)deleteAtivity:(Activity *)activity {
    [self openDB];
    sqlite3_stmt * stmt = nil;
    
    NSString  *str = @"delete from ActivityListTable where ID = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [str UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [activity.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    
    
}
//查询某个
- (Activity *)selectActivityWithID:(NSString *)ID {
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    NSString * str = @"select data from ActivityListTable where ID = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [str UTF8String], -1, &stmt, NULL);
    Activity *activity = nil;
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString *stringKey = [NSString stringWithFormat:@"%@%@",kActivityArchiver, ID];
            activity = [[ArchiverHandle shareArchiverHandle]unArchiverObject:data forkey:stringKey];
        }
    }
    sqlite3_finalize(stmt);
    
    return activity;
    
}
//查询所有
- (NSMutableArray *)selectAllActivitys {
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    NSString *str = @"select ID, data from ActivityListTable where userName = ?";
    int result = sqlite3_prepare_v2(db, [str UTF8String], -1, &stmt, NULL);
    NSMutableArray *results = [NSMutableArray array];
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *ID = [NSString stringWithUTF8String:(const char  *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *string = [NSString stringWithFormat:@"%@%@",kActivityArchiver, ID];
            Activity *activity = [[ArchiverHandle shareArchiverHandle] unArchiverObject:data forkey:string];
            [results addObject:activity];
        }
    }
    sqlite3_finalize(stmt);
    return  results;
}
//判断是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID {
    Activity *activity = [self selectActivityWithID:ID];
    if (activity == nil) {
        return NO;
    }
    return YES;
}

@end
