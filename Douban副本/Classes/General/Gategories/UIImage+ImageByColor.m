//
//  UIImage+ImageByColor.m
//  Douban
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "UIImage+ImageByColor.h"

@implementation UIImage (ImageByColor)



+(UIImage *)imageWithColor:(UIColor *)color  {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    //绘制图片
    //size 为新创建的位图的上下文的大小 (后面返回的image的大小)
    //透明开关
    //缩放因子
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //设置颜色
    //设置填充颜色
   [color setFill];
    
    //填充矩形
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
