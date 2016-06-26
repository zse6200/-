//
//  MovieCell.m
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell


- (void)setMovie:(Movie *)movie {
    if (movie!=_movie) {
        _movie = nil;
        _movie = movie;
        self.movieNameLabel.text = _movie.title;
        NSString *str = @"星级:";
        self.movistarLabel.text = [str stringByAppendingString:_movie.stars];
        NSString *str1 = @"更新时间:";
        self.movieUpdateLabel.text = [str1 stringByAppendingString:_movie.pubdate];
        //image还没有赋值
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
