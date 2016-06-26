//
//  NetWorkRequestManager.h
//  MusicPlayer
//
//  Created by lanou3g on 16/6/13.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"
//1、类型枚举GET POST
//RequestType { GET POST }
//做项目中，当需要实现某些固定类型选择的需求时，使用枚举
typedef NS_ENUM(NSUInteger, RequestType) {
    GET,
    POST,
    
};
//2.成功和失败的回调 block

//RequestSuccessed id data
typedef void(^RequestSuccessed)(id data);

//RequestFaield NSError error
typedef void(^RequestFailed)(NSError *error);

@interface NetWorkRequestManager : NSObject

//单例

singleton_interface(NetWorkRequestManager)





//2、成功和失败的回调 block


//3、接口 调用
+ (void)requestType:(RequestType)type
          urlString:(NSString *)urlSrting
              prama:(NSDictionary *)pramas success:(RequestSuccessed)success fail:(RequestFailed)fail;

//4、预留(目前没有在需求中，但是后面可能添加进需求里面的接口)



@end
