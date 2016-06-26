//
//  LoginViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <AFNetworking.h>
#import "UserFileHandle.h"
#import "DB_URL.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;//用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;    //密码输入框
@property (weak, nonatomic) IBOutlet UIButton *loginButton; //登录按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;  //高约束

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置标题
    self.title = @"登录";
    //添加取消按钮
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返 回" style:UIBarButtonItemStylePlain target:self action:@selector(isCancelled)];
    buttonItem.tintColor =  [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = buttonItem;
    
}
//取消登录
- (void)isCancelled {
    //隐藏登录页面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
//点击去注册按钮执行此方法

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//跳转到注册页面
- (IBAction)registerAction:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
//登录页面
- (IBAction)loginButtonAction:(id)sender {
    __weak LoginViewController *loginVC = self;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([alert.message isEqualToString:@"登录成功"]) {
            [loginVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alert addAction:action];
    //判断用户名和密码是否为空
    if ([_userNameTextField.text isEqualToString:@""]|| [_passwordTextField.text isEqualToString:@""]) {
        alert.message = @"用户名或密码不能为空";
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //设置参数
        NSDictionary *dicParam = @{@"userName":_userNameTextField.text,@"password":_passwordTextField.text};
        [manager POST:DB_LOGIN_URL parameters:dicParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            //解析返回结果
            if ([responseObject[@"success"]intValue] == 1) {
                //生成一个User对象
                User *user =[User new];
                NSDictionary *dic = responseObject[@"data"];
                [user setValuesForKeysWithDictionary:dic];
                user.userName = _userNameTextField.text;
                user.password = _passwordTextField.text;
                user.isLogin = YES;
                //将当前用户的信息存储到本地
              [ UserFileHandle  saveUserInfo:user];
                alert.message = @"登录成功";
                //传值
                loginVC.completion(user);

            }else {
                if ([responseObject[@"code"] intValue] ==1102) {
                    alert.message = @"登录用户不存在";
                    
                }else {
                    alert.message = @"登录失败";
                }
            }
            [loginVC presentViewController:alert animated:YES completion:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            alert.message = @"请求失败";
            [loginVC presentViewController:alert animated:YES completion:nil];
        }];
    }
    
}

//点击空白处执行此方法

- (IBAction)tapEmpty:(id)sender {
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}





#pragma mark - UITextFeld Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //键盘回收
    return [_passwordTextField resignFirstResponder] | [_userNameTextField resignFirstResponder];
}

@end
