//
//  RegisterViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "RegisterViewController.h"
#import "DB_URL.h"
#import <AFNetworking.h>

@interface RegisterViewController ()<UIImagePickerControllerDelegate,UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;  //头像
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;    //用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;    //密码输入框
@property (weak, nonatomic) IBOutlet UITextField *repasswordTextField;  //重复密码
@property (nonatomic, strong) UIImagePickerController *imagePicker; //图片选择器

@property (weak, nonatomic) IBOutlet UIButton *registerButton;  //注册按钮

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;  //高约束

@end

@implementation RegisterViewController

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    _avatarImageView.image = image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    //隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage {
    NSLog(@"存储图片...");
}
//点击头像执行此方法
- (IBAction)tapRegisterAction:(id)sender {
    //调用系统相册 相机
    //添加alartSheet
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //指定资源类型
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
        

    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
        
        
     }];
    UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:canAction];
    //显示alertController
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)tapEmpty:(id)sender {
    
}
//点击注册按钮执行此方法
- (IBAction)registerAction:(id)sender {
    //注册
    __weak RegisterViewController *registerVC = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if ([alertController.message isEqualToString:@"注册成功"]) {
            [registerVC.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    [alertController addAction:cancleAction];
    
    
    //    if (_userNameTextField.text.length <=0 ) {
    //        NSLog(@"弹出action 提示用户");
    //    }else if (_passwordTextField.text.length <= 0) {
    //
    //    }else if ([_passwordTextField.text isEqualToString:_repasswordTextField.text]){
    //        NSLog(@"不一样");
    if (
       _userNameTextField.text == nil ||
       [_userNameTextField.text isEqualToString:@""]) {
        alertController.message = @"用户名不能为空";
        [self presentViewController:alertController animated:YES completion:nil];
    }else if ([_passwordTextField.text isEqualToString:@""]) {
        alertController.message = @"密码不能为空";
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if (![_repasswordTextField.text isEqualToString:_passwordTextField.text]){
        alertController.message = @"两次密码输入不一致";
        [self presentViewController:alertController animated:YES completion:nil];
    }else {
        //进行注册
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *pram = @{@"userName":_userNameTextField.text,@"password":_passwordTextField.text};
        [manager POST:DB_REGISTER_URL parameters:pram constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //上传头像图片，表单上传
            [formData appendPartWithFileData:UIImageJPEGRepresentation(_avatarImageView.image, 0.5) name:@"avatar" fileName:@"avatar.jpg" mimeType:@"application/octet-stream"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            if ([responseObject[@"success"]intValue] == 1) {
                //注册成功 跳转到登录页面进行登录
                alertController.message = @"注册成功";
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }else {
                if ([responseObject[@"code"]intValue]==1002) {
                    alertController.message = @"用户名已存在";
                }else{
                    alertController.message = @"注册失败";
                }
                [self presentViewController:alertController animated:YES completion:nil];
            }
            //昵称已经存在
            //注册失败
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //网络请求失败
            alertController.message = @"请求失败";
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
    }
}
#pragma mark - UITexField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [_userNameTextField resignFirstResponder] | [_passwordTextField resignFirstResponder] | [_repasswordTextField resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title= @"注册";
    self.imagePicker = [[UIImagePickerController alloc] init];
}

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

@end
