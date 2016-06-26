//
//  CinemaDetailViewController.m
//  豆瓣
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "CinemaDetailViewController.h"
#import "CinemaViewController.h"
#import "CinemaCell.h"
#import "Cinema.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
//#import <BaiduMapAPI_Search/BMKPoiSearch.h>
//#import <BaiduMapAPI_Search/BMKDistrictSearch.h>
//#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface CinemaDetailViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKDistrictSearchDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView *mapView;//百度视图
}
//@property (weak, nonatomic) IBOutlet BMKMapView *mapView;


//@property (nonatomic,strong)CLLocationManager *manager;
@property (nonatomic,strong) BMKPoiSearch *searcher;//POI搜索服务
@property (nonatomic,strong)BMKGeoCodeSearch *searcher1;//地理编码

@property (nonatomic,strong) BMKDistrictSearch *districtSearch;
 @property (nonatomic,strong) BMKLocationService *service;//定位服务
//
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation CinemaDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.dataArray = [NSMutableArray array];
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
    mapView.mapType = BMKMapTypeStandard;
    //设置路况
   mapView.trafficEnabled = YES;
    //最大、最小缩放比例
    mapView.maxZoomLevel = 19;
    mapView.minZoomLevel = 3;
//    mapView.zoomLevel = 18;

    
    [self.view addSubview:mapView];
    [self addLocation];
    
    
//    //初始化检索对象
//    _districtSearch = [[BMKDistrictSearch alloc] init];
//    //设置delegate，用于接收检索结果
//    _districtSearch.delegate = self;
//    //构造行政区域检索信息类
//    BMKDistrictSearchOption *option = [[BMKDistrictSearchOption alloc] init];
//    option.city = @"北京";
//    option.district = @"海淀";
//    //发起检索
//    BOOL flag = [_districtSearch districtSearch:option];
//    if (flag) {
//        NSLog(@"district检索发送成功");
//    } else {
//        NSLog(@"district检索发送失败");
//    }
    
    
    //初始化检索对象
    _searcher1 =[[BMKGeoCodeSearch alloc]init];
    _searcher1.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//    geoCodeSearchOption.city= @"北京市";
//    geoCodeSearchOption.address = @"海淀区上地10街10号";
    //上个页面点击的地址
    geoCodeSearchOption.address = self.cinema.address;
    BOOL flag1 = [_searcher1 geoCode:geoCodeSearchOption];
   
    if(flag1)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
    
    
    
}

//周边搜索
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        //将上一次的大头针数据清空
        NSArray *array = [NSArray arrayWithArray:mapView.annotations];
        [mapView removeAnnotations:array];
        
        //将上一次添加的覆盖视图清空
        array = [NSArray arrayWithArray:mapView.overlays];
        [mapView removeOverlays:array];
        
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
       
        annotation.coordinate = result.location;
        annotation.title = self.cinema.cinemaName;
     [mapView addAnnotation:annotation];
        //设置视图中线
        mapView.centerCoordinate = result.location;
        
        
        
        
        
        
        //初始化搜索
        self.searcher = [[BMKPoiSearch alloc] init];
        self.searcher.delegate = self;
        //初始化一个周边云检索对象
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
        //索引 默认0、
        option.pageIndex = 0;
        //页数默认为0
        option.pageCapacity = 500;
        //搜索半径
        option.radius = 2000;
        //检索的中心点，经纬度
        option.location = result.location;
        //搜索关键字
        option.keyword = @"小吃";
        //    NSString *addStr = _cinema.address;
        //    NSLog(@"%@",_cinema.address);
        //    option.keyword = addStr;
        
        
        //根据中心点、半径和搜索词发起周边检索
        BOOL flag = [self.searcher poiSearchNearBy:option];
        if (flag) {
            NSLog(@"搜索成功");
            //关闭定位
            [self.service stopUserLocationService];
        }else {
            NSLog(@"搜索失败");
        }
        

    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}



/**
 *返回行政区域搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKDistrictSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
//- (void)onGetDistrictResult:(BMKDistrictSearch *)searcher result:(BMKDistrictResult *)result errorCode:(BMKSearchErrorCode)error {
//    NSLog(@"onGetDistrictResult error: %d", error);
//    if (error == BMK_SEARCH_NO_ERROR) {
//        //code
//    }else {
//        NSLog(@"未找到结果");
//    }
//}
- (void)addLocation {
    //初始化定位
    self.service = [[BMKLocationService alloc] init];
    //设置代理
    self.service.delegate = self;
    //开启定位
    [self.service startUserLocationService];
}
/**
 *  用户更新位置后，会调用此函数
 @param userLocation 新的用户位置
 */
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    //展示定位
//    mapView.showsUserLocation = YES;
//    
//    //更新数据
//    [mapView updateLocationData:userLocation];
//    //获取用户的坐标
//    mapView.centerCoordinate = userLocation.location.coordinate;
//    mapView.zoomLevel = 18;
//    
//    //初始化搜索
//    self.searcher = [[BMKPoiSearch alloc] init];
//    self.searcher.delegate = self;
//    //初始化一个周边云检索对象
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
//    //索引 默认0、
//    option.pageIndex = 0;
//    //页数默认为0
//    option.pageCapacity = 500;
//    //搜索半径
//    option.radius = 2000;
//    //检索的中心点，经纬度
//    option.location = userLocation.location.coordinate;
//    //搜索关键字
//    option.keyword = @"小吃";
////    NSString *addStr = _cinema.address;
////    NSLog(@"%@",_cinema.address);
////    option.keyword = addStr;
//    
//    
//    //根据中心点、半径和搜索词发起周边检索
//    BOOL flag = [self.searcher poiSearchNearBy:option];
//    if (flag) {
//        NSLog(@"搜索成功");
//        //关闭定位
//        [self.service stopUserLocationService];
//    }else {
//        NSLog(@"搜索失败");
//    }
//    
//    
//}
//

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
         NSArray *pointInfoList = poiResultList.poiInfoList;
        
        [pointInfoList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BMKPoiInfo *info = (BMKPoiInfo *)obj;
            NSLog(@"name=%@,address=%@",info.name,info.address);
        }];
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - BMKPosSearchDelegate




//- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
//    //若搜索成功
//    if (errorCode == BMK_SEARCH_NO_ERROR) {
//        //POI信息类
//        //POI列表
//        for (BMKPoiInfo *info in poiResult.poiInfoList) {
//            [self.dataArray addObject:info];
//            //初始化一个点的注释//只有三个属性
//            BMKPointAnnotation *annotoation = [[BMKPointAnnotation alloc] init];
//            //坐标
//            annotoation.coordinate = info.pt;
//            
//            //title
//            annotoation.title = info.name;
//            //子标题
//            annotoation.subtitle = info.address;
//            //将标注添加到地图上
//            [mapView addAnnotation:annotoation];
//            
//            
//           
//            
//            
//            
//            
//            
//            
//        }
//    }
//    
//    
//}
//
- (void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode {
    NSLog(@"%@",poiDetailResult.name);
    
    
}
#pragma MARK - BMKMapViewDelegate
-(void)viewWillAppear:(BOOL)animated
{
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor ;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    
    annotation.coordinate = coor;
    annotation.title = @"北京";
    annotation.subtitle = @"北京欢迎你";
    
    
    [mapView addAnnotation:annotation];
    
    
    
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    //如果是注视点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        //根据注视点，创建初始化注视点视图
        BMKPinAnnotationView * newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorPurple;
        //设置动画
        newAnnotation.animatesDrop = YES;
        return newAnnotation;
    }
    return nil;
}
//当选中一个 anntation views时，调用此接口


//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
//    //poi详情检索信息类
//    BMKPoiDetailSearchOption *option = [[BMKPoiDetailSearchOption alloc] init];
//    BMKPoiInfo *info = self.dataArray.firstObject;
//    
//    option.poiUid = info.uid;
//    
//    BOOL flag = [self.searcher poiDetailSearch:option];
//    if (flag) {
//        NSLog(@"检索成功");
//    }else {
//        NSLog(@"检索失败");
//    }
//}





-(void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
    _searcher1.delegate = nil;
}
@end
