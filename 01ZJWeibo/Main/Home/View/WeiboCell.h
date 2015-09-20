//
//  WeiboCell.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/24.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "ThemeLabel.h"
#import "WeiboView.h"
#import "WeiboViewLaoutFrame.h"

@interface WeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet ThemeLabel *userName;

@property (weak, nonatomic) IBOutlet ThemeLabel *createTime;
@property (strong, nonatomic) IBOutlet ThemeLabel *repostCountLabel;
@property (strong, nonatomic) IBOutlet ThemeLabel *commentCountLabel;
@property (strong, nonatomic) IBOutlet ThemeLabel *soureLabel;


//@property (nonatomic,strong) WeiboModel *model;
//@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) WeiboView *weiboView;
@property (nonatomic, strong) WeiboViewLaoutFrame *layoutFrame;
@end
