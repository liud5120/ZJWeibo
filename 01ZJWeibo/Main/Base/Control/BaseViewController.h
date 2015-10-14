//
//  BaseViewController.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/20.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ThemeManager.h"
#import "AFHTTPRequestOperation.h"

@interface BaseViewController : UIViewController{
    
    UIView *_tipView; //自己实现
    
    MBProgressHUD *_hud;
    
    UIWindow *_tipWindow;
    
}
//-(void)setNavButton;
- (void)setNavItem;
//显示加载提示-自己实现
- (void)showLoading:(BOOL)show;


//显示hud提示-开源代码
- (void)showHUD:(NSString *)title;
- (void)hideHUD;
//完成的提示
- (void)completeHUD:(NSString *)title;

- (void)setBgImage;

- (void)showStatusTip:(NSString*)title show:(BOOL)show operation:(AFHTTPRequestOperation *)operation;;
@end
