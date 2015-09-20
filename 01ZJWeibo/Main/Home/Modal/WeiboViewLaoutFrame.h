//
//  WeiboViewLaoutFrame.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/24.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface WeiboViewLaoutFrame : NSObject

@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect srTextFrame;//原微博内容的frame
@property (nonatomic, assign) CGRect bgImgFrame;
@property (nonatomic, assign) CGRect imgFrame;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) WeiboModel *weiboModel;

//是否是微博详情
@property(nonatomic,assign)BOOL isDetail;
@end
