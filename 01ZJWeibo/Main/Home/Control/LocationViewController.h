//
//  LocationViewController.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/9/1.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@end
