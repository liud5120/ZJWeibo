//
//  weiboView.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/24.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLaoutFrame.h"
#import "WXLabel.h"
#import "ZoomImageView.h"


@interface WeiboView : UIView<WXLabelDelegate>

@property (nonatomic, strong) WXLabel *textLabel;
@property (nonatomic, strong) WXLabel *sourceLabel;
@property (nonatomic, strong) ZoomImageView *imgView;
@property (nonatomic, strong) ThemeImageView *bgImageView;

@property (nonatomic, strong) WeiboViewLaoutFrame *layoutFrame;

@end
