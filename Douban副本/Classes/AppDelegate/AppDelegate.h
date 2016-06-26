//
//  AppDelegate.h
//  Douban
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) UINavigationController *navigationController;;
@property(nonatomic,strong) BMKMapManager* _mapManager;
@end

