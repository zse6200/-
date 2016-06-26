//
//  ArchiverHandle.m
//  Douban
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ArchiverHandle.h"

@implementation ArchiverHandle

singleton_implementation(ArchiverHandle)
//归档
//创建可变data
//使用data进行初始化
//开始归档
//结束归档
- (NSData *)dataOfArchiverObject:(id)object forkey:(NSString *)key {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    return data;
    
}

//反归档

- (id)unArchiverObject:(NSData *)data forkey:(NSString *)key {
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id object = [unArchiver decodeObjectForKey:key];
    return object;
    
}


@end
