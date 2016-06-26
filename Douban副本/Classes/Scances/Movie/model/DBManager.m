//
//  DBManager.m
//  Douban
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DBManager.h"
#import "ArchiverHandle.h"
#import "UserFileHandle.h"

//归档时需要的key
#define kMovieArchiver @"movie"

@interface DBManager ()

//数据库路径
@property (nonatomic, strong)NSString *databasePath;

@end

@implementation DBManager

singleton_implementation(DBManager);

- (NSString *)databasePath{
    if (_databasePath == nil) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _databasePath = [documentPath stringByAppendingPathComponent:@"DB.sqlite"];
    }
    return _databasePath;
}

//数据库指针
static sqlite3 *db = nil;

//打开数据库
- (void)openDB{
    NSLog(@"%@",self.databasePath);
    
    int result = sqlite3_open([self.databasePath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        [self createTable];
    }else{
        NSLog(@"数据库打开失败");
    }
}

//关闭数据库
- (void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }else{
        NSLog(@"失败");
    }
}

#pragma mark - movie
//创建表
- (void)createTable{
    //创建表的语句
    //如果想存储大型的数据、文件 图片 对象 可以用BLOB类型 （转成data进行存储）
    NSString *createTable = @"create table if not exists MovieListTable(userName TEXT, ID TEXT, title TEXT, imageUrl TEXT, data BLOB)";
    //执行sql语句
    int result = sqlite3_exec(db, [createTable UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
}

//插入
- (void)insertNewMovie:(Movie *)movie{
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    
    NSString * insertString = @"insert into MovieListTable(userName,ID,title,imageUrl, data) values (?,?,?,?,?)";
    int result = sqlite3_prepare_v2(db, insertString.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [movie.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [movie.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [[movie.images objectForKey:@"medium"] UTF8String], -1, NULL);
        
        NSString *archiverKey = [NSString stringWithFormat:@"%@%@",kMovieArchiver, movie.ID];
        NSData *data = [[ArchiverHandle shareArchiverHandle]dataOfArchiverObject:movie forkey:archiverKey];
        
        //        NSData *data = [[ArchiverHandle shareArchiverHandle] dataOfArchiverObject:movie forKey:archiverKey];
        //
        //blob类型的绑定
        sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
        
    }else{
        NSLog(@"插入语句错误 %d",result);
    }
    sqlite3_finalize(stmt);
}

//删除
- (void)deleteMovie:(Movie *)movie{
    [self openDB];
    sqlite3_stmt * stmt = nil;
    
    NSString * string = @"delete from MovieListTable where ID = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [movie.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

//查询某个
- (Movie *)selectMovieWithID:(NSString *)ID{
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    
    NSString *string = @"select data from MovieListTable where ID = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    Movie *movie = nil;
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString *stringKey = [NSString stringWithFormat:@"%@%@",kMovieArchiver, ID];
            //            movie = [[ArchiverHandle shareArchiverHandle] unArchiverObject:data forKey:stringKey];
            movie = [[ArchiverHandle shareArchiverHandle]unArchiverObject:data forkey:stringKey];
        }
    }
    sqlite3_finalize(stmt);
    
    return movie;
}

//查询所有
- (NSMutableArray *)selectAllMovies{
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    
    NSString *string = @"select ID, data from MovieListTable where userName = ?";
    int result = sqlite3_prepare_v2(db, [string UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *results = [NSMutableArray array];
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[UserFileHandle selectUserInfoHandle].userName UTF8String], -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *ID = [NSString stringWithUTF8String:(const char  *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *string = [NSString stringWithFormat:@"%@%@",kMovieArchiver, ID];
            //            Movie *movie = [[ArchiverHandle shareArchiverHandle] unArchiverObject:data forKey:string];
            Movie *movie = [[ArchiverHandle shareArchiverHandle]unArchiverObject:data forkey:string];
            [results addObject:movie];
        }
    }
    sqlite3_finalize(stmt);
    return  results;
}

//判断是否被收藏
- (BOOL)isFavoriteMovieWithID:(NSString *)ID{
    Movie *movie = [self selectMovieWithID:ID];
    if (movie == nil) {
        return NO;
    }
    return YES;
}


@end
