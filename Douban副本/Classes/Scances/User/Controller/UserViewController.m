//
//  UserViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "UserViewController.h"
#import "UserCell.h"
#import "MyActivityViewController.h"
#import "MyCinemaViewController.h"
#import "LoginViewController.h"
#import "ListTableViewController.h"

#import "UserFileHandle.h"
#import "User.h"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}
- (void)initView  {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClicked)];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
 
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self  action:@selector(barButtonItemClicked:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;

    
}
- (void)barButtonItemClicked:(UIBarButtonItem *)sender {
        User *user = [User new];
    UIBarButtonItem *item = sender;
    if (user.isLogin == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.completion = ^(User *user){
            
        };
        item.title = @"登录";

        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:NC  animated:YES completion:nil];
        
        
    }
    [UserFileHandle deleteUserInfo];
    NSLog(@"注销了");
    item.title = @"注销";

}

#pragma mark -- <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        UserCell *cell = [UserCell cellWithTableView:tableView];
        [cell steupDataWithIndexPath:indexPath];
       return cell;
        
        
}
#pragma mark -- <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
         LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.completion = ^(User *user){
            
        };
        
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:NC  animated:YES completion:nil];
    }else if (indexPath.row == 1) {
        
        [self.navigationController pushViewController:[[MyActivityViewController alloc]init] animated:YES];
//
        
    }else if (indexPath.row == 2){
        
        [self.navigationController pushViewController:[[MyCinemaViewController alloc]init] animated:YES];
        
    }
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
