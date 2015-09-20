 //
//  WeiboTableView.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/22.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboViewLaoutFrame.h"
#import "HomeDetailViewController.h"
#import "UIView+UIViewController.h"

static NSString *cellId = @"cellId";

@implementation WeiboTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if ([super initWithFrame:frame style:style]) {
        [self _createView];
    }
    return self;
}

- (void)awakeFromNib{
    [self _createView];
}

- (void)_createView{
    self.delegate =self;
    self.dataSource =self;
    self.backgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:cellId];
    
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.layoutFrameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeiboCell *cell= [self dequeueReusableCellWithIdentifier:cellId];
    
//    cell.model = self.dataArray[indexPath.row];
//    cell.backgroundColor = [UIColor clearColor];
    cell.layoutFrame =self.layoutFrameArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboViewLaoutFrame *weiboLayoutFrame =self.layoutFrameArray[indexPath.row];
    CGRect frame = weiboLayoutFrame.frame;
    CGFloat height = frame.size.height;
    
    return height+85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    id object = [self nextResponder];
//    
//    while (![object isKindOfClass:[UIViewController class]] &&
//           object != nil) {
//        object = [object nextResponder];
//    }
//    
//    UIViewController *vc=(UIViewController*)object;
    
    //加上以后点击不会有点击的灰色
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeDetailViewController *vc =[[HomeDetailViewController alloc]init];
    
    WeiboViewLaoutFrame *laoutFrame = self.layoutFrameArray[indexPath.row];
    
    WeiboModel *model = laoutFrame.weiboModel;
    vc.weiboModel = model;
    
    
    [self.viewController.navigationController pushViewController:vc
                                                        animated:YES];
    
    
}

@end
