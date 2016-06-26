//
//  DBManager.h
//  Douban
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <sqlite3.h>
#import "Movie.h"
@interface DBManager : NSObject
singleton_interface(DBManager)
//打开数据库
- (void)openDB;

//关闭数据库
- (void)closeDB;
//创建表
- (void)createTable;
//插入表
- (void)insertNewMovie:(Movie *)movie;
//删除
- (void)deleteMovie:(Movie *)movie;
//查询某个
- (Movie *)selectMovieWithID:(NSString *)ID;
//查询所有
- (NSMutableArray *)selectAllMovies;
//判断是够收藏
- (BOOL)isFavoriteMovieWithID:(NSString *)ID;
@end
