//
//  HomeDetailViewController.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/28.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeiboViewLaoutFrame.h"
#import "CommentTableView.h"
#import "WeiboModel.h"
#import "SinaWeibo.h"

@interface HomeDetailViewController : UIViewController<SinaWeiboRequestDelegate>
{
    
    CommentTableView *_tableView;
}

//评论的微博Model
@property(nonatomic,strong)WeiboModel *weiboModel;

//评论列表数据
@property(nonatomic,strong)NSMutableArray *data;
@end
