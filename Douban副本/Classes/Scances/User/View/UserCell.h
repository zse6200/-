//
//  UserCell.h
//  Douban
//
//  Created by lanou3g on 16/6/19.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)steupDataWithIndexPath:(NSIndexPath *)indexPath;



@end
