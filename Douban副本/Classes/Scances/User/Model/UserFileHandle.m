//
//  UserFileHandle.m
//  Douban
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "UserFileHandle.h"

#define kUserID @"userId"
#define kAvatar @"avatar"
#define kPassword @"password"
#define kIsLogin @"isLogin"
#define kUserName @"userName"

//存储对象类型
#define kUserInfoSaveObject(object,key) [[NSUserDefaults standardUserDefaults]setObject:object forKey:key]
//存储BOOL类型
#define kUserInfoSaveBOOL(value,key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]
//

@implementation UserFileHandle



//存储用户信息
+ (void)saveUserInfo:(User *)user {
    kUserInfoSaveObject(user.userID, kUserID);
    kUserInfoSaveObject(user.avatar, kAvatar);
    kUserInfoSaveObject(user.password, kPassword);
    kUserInfoSaveBOOL(user.isLogin, kIsLogin);
    kUserInfoSaveObject(user.userName, kUserName);
    
    
}

//删除用户信息
+ (void)deleteUserInfo {
    kUserInfoSaveObject(nil, kUserID);
    kUserInfoSaveObject(nil, kAvatar);
    kUserInfoSaveObject(nil, kPassword);
    kUserInfoSaveBOOL(nil, kIsLogin);
    kUserInfoSaveObject(nil, kUserName);
    
    
}
//查询用户信息

+ (User *)selectUserInfoHandle {
    User *user = [[User alloc] init];
    
    user.userName = [[NSUserDefaults standardUserDefaults]objectForKey:kUserName];
    user.password = [[NSUserDefaults standardUserDefaults]objectForKey:kPassword];
    user.avatar = [[NSUserDefaults standardUserDefaults]objectForKey:kAvatar];
    user.userID = [[NSUserDefaults standardUserDefaults]objectForKey:kUserID];
    user.isLogin = [[NSUserDefaults standardUserDefaults]objectForKey:kIsLogin];
    return user;
}
@end
