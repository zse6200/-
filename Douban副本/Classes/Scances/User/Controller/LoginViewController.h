//
//  LoginViewController.h
//  Douban
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
typedef void (^CompletionBlock)(User *user);
@interface LoginViewController : UIViewController


//登录成功时候的回调
@property (nonatomic, copy)CompletionBlock completion;
@end
