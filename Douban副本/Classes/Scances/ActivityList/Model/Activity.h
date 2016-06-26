//
//  Activity.h
//  豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface Activity : NSObject<NSCoding>
@property (nonatomic, copy) NSString *subcategory_name; //子分类
//活动图片
@property (nonatomic, copy) NSString *image;
//详情连接
@property (nonatomic, copy) NSString *adapt_url;
//所在城市
@property (nonatomic, copy) NSString *loc_name;
//举办方
@property (nonatomic, copy) NSDictionary *owner;

@property (nonatomic, copy) NSString *alt; //
//类别
@property (nonatomic, copy) NSString *category;
//活动题目
@property (nonatomic, copy) NSString *title;
//感兴趣人数
@property (nonatomic) NSInteger  wisher_count;
//是否有票
@property (nonatomic) BOOL *has_ticket;
//活动内容
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *can_invite;

@property (nonatomic, copy) NSString *album;
//参加人数
@property (nonatomic,assign) NSInteger participant_count;
//大图
@property (nonatomic, copy) NSString *image_hlarge;

@property (nonatomic, copy) NSArray *photos;
//开始时间
@property (nonatomic, copy) NSString *begin_time;
//结束时间
@property (nonatomic, copy) NSString *end_time;
//价格范围
@property (nonatomic, copy) NSString *price_range;
//地理坐标
@property (nonatomic, copy) NSString *geo;
//分类
@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, copy) NSString *loc_id;
//地址
@property (nonatomic, copy) NSString *address;
//活动id
@property (nonatomic,copy) NSString * ID;

@property (nonatomic,copy)NSString *tags;

//是否收藏
@property (nonatomic,assign)BOOL isFavorite;

@property (nonatomic,copy)NSString *imgeFilePath;//图片在沙盒中的路径

@end
