//
//  DBBManager.h
//  Douban
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#import <sqlite3.h>
#import "Activity.h"
@interface DBBManager : NSObject

singleton_interface(DBBManager)

//打开数据库
- (void)openDB;
//关闭数据库
- (void)closeDB;
#pragma mark - movie
//创建表
- (void)createTable;

//插入
- (void)insertNewActivity:(Activity *)activity;
//删除
- (void)deleteAtivity:(Activity *)activity;
//查询某个
- (Activity *)selectActivityWithID:(NSString *)ID;
//查询所有
- (NSMutableArray *)selectAllActivitys;
//判断是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID;

@end
