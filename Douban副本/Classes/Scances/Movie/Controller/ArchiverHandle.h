//
//  ArchiverHandle.h
//  Douban
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"

@interface ArchiverHandle : NSObject

singleton_interface(ArchiverHandle)

//归档
- (NSData *)dataOfArchiverObject:(id)object forkey:(NSString *)key;

//反归档

- (id)unArchiverObject:(NSData *)data forkey:(NSString *)key;
@end
