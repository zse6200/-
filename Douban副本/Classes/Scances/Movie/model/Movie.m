//
//  Movie.m
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "Movie.h"

#import "ImageDownLoader.h"



@interface Movie ()<ImageDownLoaderDelegate>

@end

@implementation Movie
//encode

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.collection forKey:@"collection"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.orignal_title forKey:@"orignal_title"];
    [aCoder encodeObject:self.original_title forKey:@"original_title"];
    [aCoder encodeObject:self.rating forKey:@"rating"];
    [aCoder encodeObject:self.pubdate forKey:@"pubdate"];
    [aCoder encodeObject:self.stars forKey:@"stars"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.wish forKey:@"wish"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.summary forKey:@"summary"];
    [aCoder encodeObject:self.genres forKey:@"genres"];
    [aCoder encodeObject:self.countries forKey:@"countries"];
    [aCoder encodeObject:self.durations forKey:@"durations"];
    [aCoder encodeObject:self.comments_count forKey:@"comments_count"];
    [aCoder encodeObject:self.imgeFilePath forKey:@"imgeFilePath"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
}

//initWithCode
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.rating = [aDecoder decodeObjectForKey:@"rating"];
        self.pubdate = [aDecoder decodeObjectForKey:@"pubdate"];
        self.wish = [aDecoder decodeObjectForKey:@"wish"];
        self.original_title = [aDecoder decodeObjectForKey:@"original_title"];
        self.orignal_title = [aDecoder decodeObjectForKey:@"orignal_title"];
        self.collection = [aDecoder decodeObjectForKey:@"collection"];
        self.stars = [aDecoder decodeObjectForKey:@"stars"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        self.genres = [aDecoder decodeObjectForKey:@"genres"];
        self.countries = [aDecoder decodeObjectForKey:@"countries"];
        self.durations = [aDecoder decodeObjectForKey:@"durations"];
        self.comments_count = [aDecoder decodeObjectForKey:@"comments_count"];
        self.imgeFilePath = [aDecoder decodeObjectForKey:@"imgeFilePath"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    key = [key isEqualToString:@"id"]?@"ID":key;
//    
//    [super setValue:value forKey:key];
//    
//    
//}
//在这个方法中通过图片链接获取图片保存在image属性中
-(void)loadImage {
    
//    NSString *imageUrlStr = self.images[@"medium"];
    [ImageDownLoader imageDownLoaderWithImageUrlString:[self.images objectForKey:@"medium"] delegate:self];
//    [ImageDownLoader imageDownLoaderWithImageUrlString:[self.images objectForKey:@"medium"] success:^(id data) {
//        
//         UIImage *image = [UIImage imageWithData:data];
//        self.image = image;
//     
//    } fail:^(NSError *error) {
//        
//    }];
    
}

#pragma mark - ImageDownloadDelegate

- (void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image {
    
    self.image = image;
    
}


@end
