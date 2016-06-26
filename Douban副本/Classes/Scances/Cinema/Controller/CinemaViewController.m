//
//  CinemaViewController.m
//  Douban
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "CinemaViewController.h"
#import "NetWorkRequestManager.h"
#import "Cinema.h"
#import "CinemaCell.h"

#import "DB_URL.h"
#import "CinemaDetailViewController.h"


@interface CinemaViewController ()
@property (nonatomic,strong)NSMutableArray *cinemaArray;

@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影院";
    self.cinemaArray = [NSMutableArray array];
    
    [self requestData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[CinemaCell class] forCellReuseIdentifier:@"cell"];
}
- (void)requestData{
    [NetWorkRequestManager requestType:GET urlString:DB_MOVIE_CINEMA_URL prama:nil success:^(id data) {
        __weak typeof(CinemaViewController) *cinemaVC = self;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary*dic = [dict objectForKey:@"result"];
        NSMutableArray *array = [dic objectForKey:@"data"];
        for (NSDictionary *di in array) {
            Cinema *cinema = [Cinema new];
            [cinema setValuesForKeysWithDictionary:di];
            [cinemaVC.cinemaArray addObject:cinema];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [cinemaVC.tableView reloadData];
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

    return self.cinemaArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cinema = self.cinemaArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaDetailViewController *cinemaDetail = [[CinemaDetailViewController alloc] init];
    Cinema *cinema = self.cinemaArray[indexPath.row];
   
    cinemaDetail.cinema = cinema;
    [self.navigationController pushViewController:cinemaDetail animated:YES];
    
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
//    self.navigationItem.title = @"影院";
//}

@end
