//
//  NearByViewController.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/9/2.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//


#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NearByViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    UITableView *_tableView;
    CLLocationManager *_locationManager;
    
    MKMapView *_mapView;
    
}
@end
