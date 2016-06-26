//
//  User.h
//  Douban
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//用户名
@property (nonatomic,strong)NSString *userName;
//密码
@property (nonatomic,strong)NSString *password;
//头像
@property (nonatomic,strong)NSString *avatar;

//ID
@property (nonatomic,strong)NSString *userID;
//是否登录
@property (nonatomic,assign)BOOL isLogin;

@end
