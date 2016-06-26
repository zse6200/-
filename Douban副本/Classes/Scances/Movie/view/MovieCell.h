//
//  MovieCell.h
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCell : UITableViewCell
//背景
@property (weak, nonatomic) IBOutlet UIView *BKGView;

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

//电影名

@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;


//星级
@property (weak, nonatomic) IBOutlet UILabel *movistarLabel;
//上映时间
@property (weak, nonatomic) IBOutlet UILabel *movieUpdateLabel;
@property (nonatomic,strong)Movie *movie;




@end
