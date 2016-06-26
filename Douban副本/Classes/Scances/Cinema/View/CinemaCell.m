//
//  CinemaCell.m
//  豆瓣
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "CinemaCell.h"
#import <UIImageView+WebCache.h>
#import "DB_COLOR.h"
#import <Masonry.h>

@interface CinemaCell ()
//影院名
@property (nonatomic,strong)UILabel *cinemaNameLabel;
//影院地址
@property (nonatomic,strong)UILabel *cinemaAddressLabel;
//电话号码
@property (nonatomic,strong)UILabel *telephoneLabel;

@end
#define kSpace 10
#define kWith [UIScreen mainScreen].bounds.size.width - kSpace *2
@implementation CinemaCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}


- (void)initView {
    
    UIView *backView = [UIView new];
    backView.backgroundColor = DB_RANDOM_COLOR;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        
    }];
    
    self.cinemaNameLabel = [[UILabel alloc] init];
//    self.cinemaNameLabel.backgroundColor = [UIColor redColor];
    
    
    [backView addSubview:self.cinemaNameLabel];
    
    [self.cinemaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(kSpace);
        make.left.equalTo(backView).offset(kSpace);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(kWith);
    }];
    
    self.cinemaAddressLabel = [[UILabel alloc] init];
    self.cinemaAddressLabel.numberOfLines = 2;
//    self.cinemaAddressLabel.backgroundColor = [UIColor yellowColor];
    self.cinemaAddressLabel.numberOfLines = 2;
    [backView addSubview:self.cinemaAddressLabel];
    [self.cinemaAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cinemaNameLabel.mas_bottom).offset(kSpace);
        make.left.equalTo(backView).offset(kSpace);
//        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kWith);
    }];
    self.telephoneLabel = [[UILabel alloc] init];
//    self.telephoneLabel.backgroundColor = [UIColor cyanColor];
    [backView addSubview:self.telephoneLabel];
    [self.telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cinemaAddressLabel.mas_bottom).offset (kSpace);
        make.left.equalTo(backView).offset(kSpace);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kWith);
    }];
    
}










- (void)setCinema:(Cinema *)cinema {
    if (cinema !=_cinema) {
        _cinema = nil;
        _cinema = cinema;
        self.cinemaNameLabel.text = cinema.cinemaName;
        self.cinemaAddressLabel.text = cinema.address;
        self.telephoneLabel.text = cinema.telephone;
        
    }
}

@end
