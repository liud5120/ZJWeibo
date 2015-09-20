//
//  WeiboTableView.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/22.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, copy)  NSArray *dataArray;
@property (nonatomic, strong) NSArray *layoutFrameArray;

@end
