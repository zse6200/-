//
//  MBProgressHUD+GifHUD.h
//  
//
//  Created by lanou3g on 16/6/17.
//
//

#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImage+GIF.h>
#import "DB_COLOR.h"

@interface MBProgressHUD (GifHUD)


//设置Gif





+(void)setUpGifWithFrame:(CGRect)frame gifName:(NSString *) gifName andShowToView:(UIView*)view;








@end
