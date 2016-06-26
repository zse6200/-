//
//  UIButton+UserButton.h
//  DJPictureViewerExample
//
//  Created by lanou3g on 16/6/19.
//  Copyright © 2016年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UserButton)



+ (UIButton *)buttonWithSuperView:(UIView *)superView target:(id)target action:(SEL)action;

@end
