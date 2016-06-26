//
//  ActivityListViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ActivityListViewController.h"
#import "NetWorkRequestManager.h"

#import "DB_URL.h"
#import "MBProgressHUD+GifHUD.h"

#import "DB_COLOR.h"

#import "ActivityCell.h"
#import "Activity.h"
#import "ActivityDetailViewController.h"

@interface ActivityListViewController ()
@property (nonatomic,strong)NSMutableArray *activityListArray;

@end

@implementation ActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self request];
    
    self.activityListArray = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //注册cell
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:@"cell"];
}
- (void)request {
    
    [NetWorkRequestManager requestType:GET urlString:DB_MOVIE_ACTIVITY_URL prama:nil success:^(id data) {
        __weak typeof(self)weakSelf = self;
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([[dict objectForKey:@"events"]count] >0) {
      
        NSArray *array = [dict objectForKey:@"events"];
        for (NSDictionary *dic in array) {
            Activity *model = [Activity new];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.activityListArray addObject:model];
        }
    }
        dispatch_async(dispatch_get_main_queue()
                       , ^{
                           [self.tableView reloadData];
//                           NSLog(@"%@",self.activityListArray);
                       });
        

        
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.activityListArray.count;
  
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = DB_RANDOM_COLOR;
    cell.activity = self.activityListArray[indexPath.row];
    
    
//    NSLog(@"%@",cell.activity);
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityDetailViewController *activityDetail = [[ActivityDetailViewController alloc] init];
   Activity *activity = [self.activityListArray objectAtIndex:indexPath.row];
    
    activityDetail.activity = activity;
    
    
    [self.navigationController pushViewController:activityDetail animated:YES];
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
//    self.navigationItem.title = @"活动";
//}
#pragma mark -- 计算文本高度
//- (CGFloat)calculateTextHeightWithActivity:(Activity *)ativity
//{
//    CGSize size = CGSizeMake(_summaryLabel.frame.size.width, 1000000);
//    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:24.0f]};
//    
//    CGRect frame = [movie.summary boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
//    return  frame.size.height;
//    
//}

@end
