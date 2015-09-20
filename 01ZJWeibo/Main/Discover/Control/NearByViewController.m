//
//  NearByViewController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/9/2.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "NearByViewController.h"
#import "DataService.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "HomeDetailViewController.h"

@interface NearByViewController ()

@end




@implementation NearByViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近微博";
    [self _createViews];
    [self _location];
}


- (void)_createViews{
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    //显示用户信息
    _mapView.showsUserLocation = YES;
    //地图危险 卫星 标准 混合
    _mapView.mapType = MKMapTypeStandard;
    
    //代理
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}


//一 大头针  实现协议方法，返回标注视图
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
//    //MKUserLocation  用户当前位置的类
//
//
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//
//
//    //复用池，得到 大头针标注视图
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//
//    if (pinView == nil) {
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
//
//        //1  设置大头针颜色
//        pinView.pinColor = MKPinAnnotationColorGreen;
//
//        //2  从天而降动画
//        pinView.animatesDrop = YES;
//
//        //3 设置显示标题
//        pinView.canShowCallout = YES;
//        //添加辅助视图
//        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//
//
//    }
//
//    return pinView;
//
//
//}


// 二 项目中 微博标注视图（自定义） 创建
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //得到标注视图
    WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    
    if (annotationView == nil) {
        annotationView = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    
    annotationView.annotation = annotation;
    return annotationView;
    
    
}


//选中标注视图的协议方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    // return;
    
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    HomeDetailViewController *detailVC = [[HomeDetailViewController alloc] init];
    
    WeiboAnnotation *annoation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = annoation.weiboModel;
    
    detailVC.weiboModel = weiboModel;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



- (void)_location{

    // 2.定位
    _locationManager = [[CLLocationManager alloc] init];
    if (kVersion >= 8.0) {
        // 请求允许定位
        [_locationManager requestWhenInUseAuthorization];
    }
    // 设置请求的准确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    // 开始定位
    [_locationManager startUpdatingLocation];
}

//代理 获取定位数据
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    //停止定位
    [_locationManager stopUpdatingLocation];
    //取得位置信息
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度%lf,纬度%lf",coordinate.longitude,coordinate.latitude);
    
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    // 开始加载网络
    [self _loadNearByData:lon lat:lat];
    
    //3 设置显示区域
    CLLocationCoordinate2D center = coordinate;
    
    //数值越小 显示范围越小
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {center,span};
    
    [_mapView setRegion:region];
    
    
    
    
}



//获取附近微博
- (void)_loadNearByData:(NSString *)lon lat:(NSString *)lat{
    
    
    //修改 AFNetWorking 支持 text/html  AFURLResponseSerialization.m中
    //self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        
        NSMutableArray *annotationArray = [[ NSMutableArray alloc] initWithCapacity:statuses.count];
        
        
        for (NSDictionary *dataDic in statuses) {
            
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
            
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
            annotation.weiboModel = model;
            
            [annotationArray addObject:annotation];
            
            
        }
        
        [_mapView addAnnotations:annotationArray];
        
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
