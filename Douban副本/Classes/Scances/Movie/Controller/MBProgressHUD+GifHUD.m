//
//  MBProgressHUD+GifHUD.m
//  
//
//  Created by lanou3g on 16/6/17.
//
//

#import "MBProgressHUD+GifHUD.h"

@implementation MBProgressHUD (GifHUD)


+(void)setUpGifWithFrame:(CGRect)frame gifName:(NSString *) gifName andShowToView:(UIView*)view{
    //使用MBProgress 播放gif 需要自定义视图显示
    UIImage *image = [UIImage sd_animatedGIFNamed:gifName];

    UIImageView *gifView = [[UIImageView alloc] initWithFrame:frame];
    
    gifView.image = image;
    
    
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    
//    hud.customView = gifView;
    hud.color = DB_COLOR(10, 250, 50, 0.5);
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"正在加载";
    hud.customView = gifView;
}
@end
