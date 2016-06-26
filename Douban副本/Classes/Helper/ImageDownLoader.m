//
//  ImageDownLoader.m
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ImageDownLoader.h"
#import "DB_COLOR.h"
@implementation ImageDownLoader

+ (instancetype)imageDownLoaderWithImageUrlString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate{
    return [[[self class] alloc]initWithImageUrlString:urlString delegate:delegate];
}

//+ (instancetype)imageDownLoaderWithImageUrlString:(NSString *)urlString success:(RequestSuccessed)success fail:(RequestFailed)fail {
//    return [[[self class] alloc] initWithImageUrlString:urlString success:success fail:fail];

//}

//- (instancetype)initWithImageUrlString:(NSString *)urlString success:(RequestSuccessed)success fail:(RequestFailed)fail {//网络请求
//    //返回得到的url
//    
//    if (self = [super init]) {
//        __weak typeof(ImageDownLoader) *downloader = self;
//        //先去判断是不是在disk caches memory
//        //如果都没有才会根据地址请求数据
//        
//        
//        NSURLSession *session = [NSURLSession sharedSession];
//        //准备url
//        NSURL *url = [NSURL URLWithString:urlString];
//        //创建request
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        //创建爱你链接对象，发送请求
//        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            //            NSError *error = nil;
//            
//            if (!data) {
//                return ;
//            }
//            if (error) {
//                if (fail) {
//                    fail(error);
//                }
//            }
//            if (data &&!error) {
//                
//           
//            if (success) {
//              
//                
//                success (data);
//             }
//            }
//        }];
//        [task resume];
//    }
//    
//    return self;
//
//    
//}





- (instancetype)initWithImageUrlString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate {
    //网络请求
    //返回得到的url
    
    if (self = [super init]) {
        __weak typeof(ImageDownLoader) *downloader = self;
        //先去判断是不是在disk caches memory
        //如果都没有才会根据地址请求数据
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        //准备url
        NSURL *url = [NSURL URLWithString:urlString];
        //创建request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //创建爱你链接对象，发送请求
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            NSError *error = nil;
            
            if (!data) {
                return ;
            }
            
            //传值
            UIImage *image = [UIImage imageWithData:data];
            //执行协议方法
            dispatch_async(dispatch_get_main_queue(), ^{
//
                [delegate imageDownLoader:downloader didFinishedLoading:image];
            });
        }];
        [task resume];
    }
    
    return self;
}

@end
