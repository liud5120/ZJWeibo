//
//  MoreTableViewCell.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/21.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLabel.h"
#import "ThemeImageView.h"
#import "ThemeManager.h"


@interface MoreTableViewCell : UITableViewCell

@property (nonatomic, strong) ThemeImageView *themeImageView;
@property (nonatomic, strong) ThemeLabel *themeTextLabel;
@property (nonatomic, strong) ThemeLabel *themeDetailLabel;

@end
