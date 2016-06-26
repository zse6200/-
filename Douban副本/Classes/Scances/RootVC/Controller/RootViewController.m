//
//  RootViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "RootViewController.h"
#import "ActivityListViewController.h"
#import "UserViewController.h"
#import "MovieListViewController.h"
#import "CinemaViewController.h"
#import "DB_COLOR.h"

#import "UIImage+ImageByColor.h"
#import "AddListViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建四个根视图控制器
    
    [self createChildViewControllers];
    //设置tabBarItem文本标题颜色
    
    [self setTabBarItemTextttributes];
    
    //设置tabBar的背景图
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:DB_RANDOM_COLOR]];
    
    [self addTabBar];
    
}
//设置tabBarItem的文本标题颜色
- (void)setTabBarItemTextttributes{
    //设置普通状态下的文本颜色
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr [NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    [selectAttr setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    //配置文本属性
    
    UITabBarItem * tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:normalAttr forState:(UIControlStateNormal)];
    [tabbarItem setTitleTextAttributes:selectAttr forState:(UIControlStateSelected)];
}


- (void)createChildViewControllers{
    
   
    [self addOneChildViewController:[[ActivityListViewController alloc]initWithStyle:UITableViewStylePlain ] title:@"活动" normalImage:@"paper" selectedImage:@"paperH"];
     [self addOneChildViewController:[[MovieListViewController alloc]initWithStyle:UITableViewStylePlain ] title:@"电影" normalImage:@"video" selectedImage:@"video"];
    [self addOneChildViewController:[[AddListViewController alloc]init] title:@"发布" normalImage:@"btn_card@2x" selectedImage:@"btn_card@2x"];
    

    
    [self addOneChildViewController:[[CinemaViewController alloc]initWithStyle:UITableViewStylePlain ] title:@"影院" normalImage:@"2image" selectedImage:@"2imageH"];
          [self addOneChildViewController:[[UserViewController alloc]init] title:@"个人中心" normalImage:@"person" selectedImage:@"personH"];
    
}

- (void)addOneChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    viewController.view.backgroundColor = DB_RANDOM_COLOR;
    
    viewController.title = title;
    viewController.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:normalImage];
    UIImage *image = [UIImage imageNamed:selectedImage];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    
      //添加子视图
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:viewController]];

    
    
}


- (void)addTabBar {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -10, self.tabBar.frame.size.width+20, self.tabBar.frame.size.height+10)];
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -10, self.tabBar.frame.size.width, self.tabBar.frame.size.height+10)];

//    view.backgroundColor = DB_MAIN_COLOR;
//    [imageView addSubview:view];
    
    [imageView setImage:[UIImage imageNamed:@"tabbar_bg@3x"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.tabBar insertSubview:imageView atIndex:0];
    //覆盖原生Tabbar的上横线
    
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    
    //设置TintColor
    UITabBar.appearance.tintColor = [UIColor orangeColor];
    
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//设置中间按钮不受TintColor影响
- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *items =  self.tabBar.items;
    UITabBarItem *btnAdd = items[3];
    btnAdd.image = [btnAdd.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    btnAdd.selectedImage = [btnAdd.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
