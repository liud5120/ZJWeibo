//
//  LocationModal.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/9/1.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModal : BaseModel
@property (nonatomic ,copy) NSString *poiid;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *lon;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *icon;
@end
