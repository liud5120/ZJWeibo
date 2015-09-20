//
//  LocationViewController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/9/1.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "LocationViewController.h"
#import "DataService.h"
#import "LocationModal.h"
#import "UIImageView+WebCache.h"


@interface LocationViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    CLLocationManager *_locationManager;

    
    
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self _createTableView];
    
    [self _location];
    
    
}

- (void)_loadDataWithlon:(NSString *)lon lat:(NSString *)lat
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:@50 forKey:@"count"];
    
     [DataService requestUrl:@"place/nearby/pois.json" httpMethod:@"GET" params:params block:^(id result) {
        
        NSArray *poiss = [result objectForKey:@"pois"];
        
        NSMutableArray *dataList = [NSMutableArray array];
        
        for (NSDictionary *dic in poiss) {
            
            
            LocationModal *modal = [[LocationModal alloc]initWithDataDic:dic];
            
            [dataList addObject:modal];
        }
        _dataArray =dataList;
        [_tableView reloadData];
    }];

}

- (void)_location
{
    
    if (_locationManager == nil ) {
        _locationManager = [[CLLocationManager alloc]init];
        if (kVersion >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    _locationManager.delegate =self;
    [_locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    
    [_locationManager stopUpdatingLocation];
    //取得位置信息
    CLLocation *location = [locations lastObject];

    
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    [self _loadDataWithlon:lon lat:lat];

}



- (void)_createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    
    
    [self.view addSubview:_tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *locCellId = @"locCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locCellId];
    }
    LocationModal *modal =_dataArray[indexPath.row];
    NSString* iconStr =modal.icon;
    NSURL *urlStr = [NSURL URLWithString:iconStr];
    [cell.imageView sd_setImageWithURL:urlStr];
    
    cell.textLabel.text =modal.title;
    return cell;
}

- (void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
