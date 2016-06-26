//
//  MovieListViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "MovieListViewController.h"
#import "NetWorkRequestManager.h"
#import "Movie.h"
#import "MovieCell.h"
#import "DB_URL.h"
#import "MBProgressHUD+GifHUD.h"
#import "MovieDetailViewController.h"

@interface MovieListViewController ()
//存储movie对象的数组
@property (nonatomic,strong)NSMutableArray *allMoviesArray;

@end

@implementation MovieListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.allMoviesArray = [NSMutableArray array];
    //网络请求
    [self request];
    
    //加载等待视图
    
    [self showGifView];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)showGifView {
    //加载等待视图
    [MBProgressHUD setUpGifWithFrame:CGRectMake(0, 0, 50, 50) gifName:@"123" andShowToView:self.view];
}
- (void)hideGifView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)request {
    __weak typeof(self)movieVC = self;
    [NetWorkRequestManager requestType:GET urlString:DB_MOVIE_LIST_URL prama:nil success:^(id data) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //数据安全判断 [判断正在上映的电影不等于0]
        if ([dic[@"total"] intValue] !=0) {
            NSArray *allDataArray = dic[@"entries"];
            for (NSDictionary *dict in allDataArray) {
                Movie *movie = [[Movie alloc]init];
                [movie setValuesForKeysWithDictionary:dict];
//                NSLog(@"%@",movie);
                [_allMoviesArray addObject:movie];
                
//                [_allMoviesArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//                    Movie *movie1 = [Movie new];
//                }];
                
                //可以将数据通过时间进行排序
                [_allMoviesArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    
                    Movie *movie1 = (Movie *)obj1;
                    Movie *movie2 = (Movie *)obj2;
                    return [movie2.pubdate compare:movie1.pubdate];
                    
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue()
                       , ^{
//                          //刷新页面
//                           [movieVC.tableView reloadData];
//                           //隐藏菊花
//                           [movieVC hideGifView];
                           [self updateUI];
                       });
        
    } fail:^(NSError *error) {
        NSLog(@"请求movie列表失败 %@",error);
    }];
}
//刷新页面
- (void)updateUI {
    [self.tableView reloadData];
    [self hideGifView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _allMoviesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  //设置cell的数据
    Movie *movie = self.allMoviesArray[indexPath.row];
    cell.movie = movie;
    if (movie.image != nil) {
        cell.movieImage.image = movie.image;
        
    }else {
        [movie loadImage];
        //使用KVO监听image的变化
        [movie addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:(void *)CFBridgingRetain(indexPath)];
//        [movie addObserver:self forKeyPath:@"image" options:(NSKeyValueObservingOptionNew) context:(void *)CFBridgingRetain(indexPath)];
    }
    
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    //获取图片
    UIImage *image = change[NSKeyValueChangeNewKey];
    
    //获取cell的位置
    
    NSIndexPath *indexPath = (__bridge NSIndexPath *)context;
#warning 注意这里
    //获取当前cell
    MovieCell *cell
    = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.movieImage.image = image;
    //释放掉indexPath的权限
    CFBridgingRelease((__bridge CFTypeRef _Nullable)(indexPath));
    
    //移除观察者
    [object removeObserver:self forKeyPath:@"image" context:context];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *movieDVC = [[MovieDetailViewController alloc] init];
    Movie *movie = [self.allMoviesArray objectAtIndex:indexPath.row];
    
    movieDVC.movie = movie;
    
    [self.navigationController pushViewController:movieDVC animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)viewDidAppear:(BOOL)animated {
//    self.navigationItem.title = @"电影";
//}

@end
