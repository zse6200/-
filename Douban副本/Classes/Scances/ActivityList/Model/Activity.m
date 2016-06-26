//
//  Activity.m
//  豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "Activity.h"

@implementation Activity


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

//encode
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.subcategory_name forKey:@"subcategory_name"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.adapt_url forKey:@"adapt_url"];
    [aCoder encodeObject:self.loc_name forKey:@"loc_name"];
    [aCoder encodeObject:self.owner forKey:@"owner"];
    [aCoder encodeObject:self.alt forKey:@"alt"];
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.tags forKey:@"tags"];
    [aCoder encodeInteger:self.wisher_count forKey:@"wisher_count"];
    [aCoder encodeObject:self.image forKey:@"image"];
//    [aCoder encodeBool:self.has_ticket forKey:@"has_ticket"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.can_invite forKey:@"can_invite"];
    [aCoder encodeObject:self.album forKey:@"album"];
    [aCoder encodeInteger:self.participant_count forKey:@"participant_count"];
    [aCoder encodeObject:self.photos forKey:@"photos"];
    [aCoder encodeObject:self.begin_time forKey:@"begin_time"];
    [aCoder encodeObject:self.end_time forKey:@"end_time"];
   [aCoder encodeObject:self.price_range forKey:@"price_range"];
     [aCoder encodeObject:self.geo forKey:@"geo"];
     [aCoder encodeObject:self.category_name forKey:@"category_name"];
     [aCoder encodeObject:self.loc_id forKey:@"loc_id"];
     [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
}

//initwithCoder
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.adapt_url = [aDecoder decodeObjectForKey:@"adapt_url"];
        self.loc_name = [aDecoder decodeObjectForKey:@"loc_name"];
        self.owner = [aDecoder decodeObjectForKey:@"owner"];
        self.alt = [aDecoder decodeObjectForKey:@"alt"];
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.wisher_count = [aDecoder decodeIntegerForKey:@"wisher_count"];
//        self.has_ticket =  [aDecoder decodeBoolForKey:@"has_ticket"];
        self.tags = [aDecoder decodeObjectForKey:@"tags"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.can_invite = [aDecoder decodeObjectForKey:@"can_invite"];
        self.album = [aDecoder decodeObjectForKey:@"album"];
        self.participant_count = [aDecoder decodeIntegerForKey:@"participant_count"];
        self.begin_time = [aDecoder decodeObjectForKey:@"begin_time"];
        self.image_hlarge = [aDecoder decodeObjectForKey:@"image_hlarge"];
        self.end_time = [aDecoder decodeObjectForKey:@"end_time"];
        self.price_range = [aDecoder decodeObjectForKey:@"price_range"];
        self.geo = [aDecoder decodeObjectForKey:@"geo"];
        self.category_name = [aDecoder decodeObjectForKey:@"category_name"];
        self.loc_id = [aDecoder decodeObjectForKey:@"loc_id"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
    }
    return self;
}



@end
