//
//  ActivityDetailViewController.m
//  豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ActivityDetailViewController.h"

#import "NetWorkRequestManager.h"
#import "DB_URL.h"
#import "ImageDownLoader.h"
#import <UIImageView+WebCache.h>
#import "UMSocial.h"

#import "DBBManager.h"
#import "UserFileHandle.h"

#import "Activity.h"

@interface ActivityDetailViewController ()<ImageDownLoaderDelegate,UMSocialUIDelegate>
@property (nonatomic,strong)NSMutableArray *activityDetailArray;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
//    [self requestData];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"活动详情";
    self.activityDetailArray = [NSMutableArray array];
  
}
- (void)initView {
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *barButtonItem1 =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItem1Clicked)];
    //收藏按钮
    UIBarButtonItem *favItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(favAvaction:)];
    self.navigationItem.rightBarButtonItems = @[barButtonItem1,favItem];
    
    BOOL isFav = [[DBBManager shareDBBManager] isFavoriteActivityWithID:_activity.ID];
    if (isFav) {
        favItem.title = @"取消收藏";
    }

    
    
    NSString *str = _activity.begin_time;
    NSString *stri = [str substringFromIndex:5];
    NSString *strin = [stri substringToIndex:11];
    NSString *str1 = _activity.end_time;
    NSString *stri1 = [str1 substringFromIndex:5];
    NSString *strin1 = [stri1 substringToIndex:11];
    self.timeLabel.text = [NSString stringWithFormat:@"%@%@%@",strin, @"--" , strin1];
    
    [_smallImageView sd_setImageWithURL:[NSURL URLWithString:_activity.image]];
    //
    _titleLabel.text = _activity.title;
    
    NSString *typeStr = @"类型:";
    _typeLabel.text = [typeStr stringByAppendingString:_activity.category_name];
    _addressLabel.text = _activity.address;
    _descLabel.text = _activity.content;
    _personLabel.text = _activity.tags;
    //计算详情高度
    CGRect frame = _descLabel.frame;
    frame.size.height = [self calculateTextHeightWithActivity:_activity];
    _descLabel.frame = frame;
    //给约束赋值
    CGSize size = CGSizeMake(_scrollView.frame.size.width, _descLabel.frame.size.height);
    
        self.contViewHeight.constant  = size.height;    
}

#pragma mark -- 计算文本高度
- (CGFloat)calculateTextHeightWithActivity:(Activity *)activity
{
    CGSize size = CGSizeMake(_descLabel.frame.size.width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:24.0f]};
    
    CGRect frame = [activity.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}


//- (void)showUIWithMovieInfo:(Activity*)ativity {
//    
//    
//    
//    _timeLabel.text = ativity.title;
//    
//    
//    
//}
- (void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image {
    _smallImageView.image = image;
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

- (void)barButtonItem1Clicked {
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576561e4e0f55afe11000c55"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
    
}
//收藏
- (void)favAvaction:(UIBarButtonItem *)sender {
    //先判断是不是登录
    
    if ([UserFileHandle selectUserInfoHandle].isLogin) {
        [self favAvactionMovie:sender];
    }
    else {
        //跳转登录页面
    }
}
- (void)favAvactionMovie:(UIBarButtonItem *)sender {
    //先判断是不是登录
    BOOL isFav = [[DBBManager shareDBBManager] isFavoriteActivityWithID:_activity.ID];
    UIBarButtonItem *item = sender;
    if (isFav) {
        
        //z取消收藏
        [[DBBManager shareDBBManager]deleteAtivity:_activity];
        item.title = @"收藏";
        NSLog(@"取消收藏");
        
        return;
    }
    [[DBBManager shareDBBManager]insertNewActivity:_activity];
    item.title = @"取消收藏";
    NSLog(@"收藏成功");
    
}


@end
