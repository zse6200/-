//
//  ImageDownLoader.h
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@class ImageDownLoader;
@protocol ImageDownLoaderDelegate <NSObject>

//当获取到image的时候，代理对象执行方法

- (void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image;

@end
//typedef void(^RequestSuccessed)(id data);
//typedef void(^RequestFailed)(NSError *error);
@interface ImageDownLoader : NSObject
//@property (nonatomic,weak) id<ImageDownLoaderDelegate>delegate;

//- (instancetype)initWithUrlString:(NSString *)urlString;
//可以将delegate直接作为参数设置，避免可能出现的忘记设置代理问题

- (instancetype)initWithImageUrlString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate;
//- (instancetype)initWithImageUrlString:(NSString *)urlString success:(RequestSuccessed)success fail:(RequestFailed)fail;

+ (instancetype)imageDownLoaderWithImageUrlString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate;
//+ (instancetype)imageDownLoaderWithImageUrlString:(NSString *)urlString success:(RequestSuccessed)success fail:(RequestFailed)fail;

@end
