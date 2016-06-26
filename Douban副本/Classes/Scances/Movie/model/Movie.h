//
//  Movie.h
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject<NSCoding>



@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSString *rating;
@property (nonatomic,copy)NSString *pubdate;
@property (nonatomic,strong)NSNumber *wish;
@property (nonatomic,copy)NSString *original_title;
@property (nonatomic,copy)NSString *orignal_title;
@property (nonatomic,strong)NSString *stars;
@property (nonatomic,strong)NSString *collection;
@property (nonatomic,strong)NSDictionary *images;
@property (nonatomic,copy)NSString *ID;

@property (nonatomic,strong)UIImage *image;



// 电影简介
@property (nonatomic, copy) NSString *summary;
// 分类
@property (nonatomic, strong) NSArray *genres;
// 国家
@property (nonatomic, strong) NSArray *countries;
// 时长
@property (nonatomic, strong) NSArray *durations;
//评论人数
@property (nonatomic, strong) NSString *comments_count;



- (void)loadImage;
//是否收藏
@property (nonatomic,assign)BOOL isFavorite;

@property (nonatomic,copy)NSString *imgeFilePath;//图片在沙盒中的路径



@end
