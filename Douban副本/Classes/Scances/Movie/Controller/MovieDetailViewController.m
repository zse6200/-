//
//  MovieDetailViewController.m
//  豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "MovieDetailViewController.h"

#import "NetWorkRequestManager.h"
#import "DB_URL.h"
#import "ImageDownLoader.h"
#import "UMSocial.h"

#import "LoginViewController.h"
#import "DBManager.h"
#import "UserFileHandle.h"


@interface MovieDetailViewController ()<ImageDownLoaderDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieCountryLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
//@property (nonatomic,assign)BOOL isFav;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //请求数据
    [self requestData];
    
    [self initView];
}
- (void)initView {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *barButtonItem1 =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItem1Clicked)];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collect@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(favAvaction:)];
    self.navigationItem.rightBarButtonItems = @[barButtonItem2,barButtonItem1];
    BOOL isFav = [[DBManager shareDBManager]isFavoriteMovieWithID:_movie.ID];
//     isFav = [[DBManager shareDBManager]isFavoriteMovieWithID:_movie.ID];
    if (isFav) {
        barButtonItem2.title = @"取消收藏";
    }

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
    BOOL isFav = [[DBManager shareDBManager]isFavoriteMovieWithID:_movie.ID];
     UIBarButtonItem *item = sender;
    if (isFav) {
       
        //z取消收藏
        [[DBManager shareDBManager]deleteMovie:_movie];
        item.title = @"收藏";
        NSLog(@"取消收藏");
//        _isFav = NO;
        return;
    }
        [[DBManager shareDBManager]insertNewMovie:_movie];
         item.title = @"取消收藏";
    NSLog(@"收藏成功");
//    _isFav = YES;
    
}


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
//- (void)barButtonItem2Clicked:(UIBarButtonItem *)sender{
//    
//[self favAvaction:sender];
//    
//}


- (void)requestData {
    __weak MovieDetailViewController *movieDetail = self;
    
    //拼接网址
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",DB_MOVIE_BASE_URL,_movie.ID,DB_MOVIE_DETAIL_URL];
    [NetWorkRequestManager requestType:GET urlString:urlString prama:nil success:^(id data) {
        //解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //转成模型对象
        Movie *movie_d = [Movie new];
        [movie_d setValuesForKeysWithDictionary:dic];
        //进行展示
        dispatch_async(dispatch_get_main_queue(), ^{
           
            //
            
            [movieDetail showUIWithMovieInfo:movie_d];
            
        });
        
    } fail:^(NSError *error) {
        NSLog(@"请求错误！！！");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showUIWithMovieInfo:(Movie *)movie {
    //请求图片
    [ImageDownLoader imageDownLoaderWithImageUrlString:movie.images[@"large"] delegate:self];
    
    
    
    _gradeLabel.text = [NSString stringWithFormat:@"评分: %@ (评分%@)",_movie.rating,movie.comments_count];
    _pubdateLabel.text = movie.pubdate;
    _movieTimeLabel.text = [self stringByArray:movie.durations];
    _movieTypeLabel.text = [self stringByArray:movie.genres];
    _movieCountryLabel.text = [self stringByArray:movie.countries];
    //详情
    _summaryLabel.text = movie.summary;
    //计算详情高度
    CGRect frame = _summaryLabel.frame;
    frame.size.height = [self calculateTextHeightWithMovie:movie];
    _summaryLabel.frame = frame;
    //给约束赋值
    CGSize size = CGSizeMake(_scrollView.frame.size.width, _summaryLabel.frame.size.height+100);
             self.contentViewHeight.constant  = size.height
        ;
  
 
        
}

- (void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image {
    
   _movieImageView.image = image;
    
}

#pragma mark -- 计算文本高度
- (CGFloat)calculateTextHeightWithMovie:(Movie *)movie
{
    CGSize size = CGSizeMake(_summaryLabel.frame.size.width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:24.0f]};
    
    CGRect frame = [movie.summary boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}

- (NSString *)stringByArray:(NSArray *)array {
    NSMutableString *string = [NSMutableString string];
    for (NSString *str in array) {
        [string appendFormat:@"%@ ",str];
    }
    return string;
}

/*#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
