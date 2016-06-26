//
//  UserCell.m
//  Douban
//
//  Created by lanou3g on 16/6/19.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "UserCell.h"
#import <Masonry.h>

#import "DB_COLOR.h"

@interface UserCell ()
//显示内容
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *imageView1;

@end
@implementation UserCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self stepLayout];
    }
    return self;
}

- (void)stepLayout {
    //添加一个背景视图
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
//    backView.backgroundColor = DB_RANDOM_COLOR;
    __weak typeof(UserCell) *cell = self;
    //将
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //添加约束
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
    }];

    
    //要显示的内容
    self.contentLabel = [[UILabel alloc] init];
    
    _contentLabel.textAlignment = NSTextAlignmentLeft;
//    _contentLabel.backgroundColor = [UIColor redColor];
    [backView addSubview:_contentLabel];
    self.contentLabel = _contentLabel;
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(0);
        make.left.equalTo(backView).offset(10);
        make.right.equalTo(backView).offset(-100);
        make.height.mas_equalTo(30);
      
        
    }];
   self.imageView1 = [[UIImageView alloc] init];

    [backView addSubview:self.imageView1];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backView.mas_top).with.offset(0);
        make.top.equalTo(backView).offset(0);
        make.right.equalTo(backView).offset(-50);
        
    make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
      }];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"MyActivityViewController";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

- (void)steupDataWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _contentLabel.text = @"登录";
        self.imageView1.image = [UIImage imageNamed:@"DefaultAvatar"];
    }else if (indexPath.row == 1) {
        _contentLabel.text = @"活动收藏";
        self.imageView1.image = [UIImage imageNamed:@"collect"];

        
    }
    else if (indexPath.row == 2)  {
        self.contentLabel.text = @"电影收藏";
        self.imageView1.image = [UIImage imageNamed:@"collect"];
           }else {
               self.contentLabel.text =@"清除缓存";
               self.imageView1.image = [UIImage imageNamed:@"collect"];

        
    }
    
}
@end
