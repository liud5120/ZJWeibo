//
//  MainViewController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/19.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"

@implementation MainViewController
{
    ThemeImageView *_tabbarView;
    ThemeImageView *_selectImgView;
    
    ThemeImageView *_badgeView;
    ThemeLabel *_badgeLabel;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _createViewControllers];
    [self _createTabbarView ];
    
    //3.定时器 请求 未读消息
    [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}



//创建选项栏
- (void)_createTabbarView
{
    
    _tabbarView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, kHeight - 49, kWidth, 49)];
    _tabbarView.imgName = @"mask_navbar.png";
    
    _tabbarView.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabbarView];
    
    _selectImgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0,0, kWidth/5, 49)];
    _selectImgView.imgName =  @"home_bottom_tab_arrow.png";
    
    [_tabbarView addSubview:_selectImgView];
    
    CGFloat itemWidth = kWidth/4.0;
    NSArray *imgNames = @[
                          @"home_tab_icon_1.png",
                          //@"home_tab_icon_2.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_5.png",
                          ];
    
    for (int i = 0; i < imgNames.count; i++) {
        NSString *name = imgNames[i];
        
        ThemeButton *btn = [[ThemeButton alloc]initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, 49)];
        btn.normalImgName = name;

        
        btn.tag = i;
        [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:btn];
        
    
    }
}

- (void)selectTab:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        _selectImgView.center = btn.center;
    }];
    self.selectedIndex =btn.tag;
    //[self. setSelectIndex:btn.tag];
}
//- (void)setSelectIndex:(NSInteger)selectIndex
//{
//    if (_selectIndex != selectIndex) {
//        
//        UIViewController *lastVC = self.childViewControllers[_selectIndex];
//        
//        UIViewController *currentVC = self.childViewControllers[selectIndex];
//        
//        [lastVC.view removeFromSuperview];
//        
//        [self.view insertSubview:currentVC.view belowSubview:_tabbarView];
//        
//        _selectIndex =selectIndex;
//    }
//}

//创建子控制器
- (void)_createViewControllers{

    NSArray *storyboardNames = @[@"Home",@"Discover",@"Profile",@"More"];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    
    for (int i = 0 ; i < storyboardNames.count; i++) {
        
        NSString *name = storyboardNames[i];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController *nav = [storyboard instantiateInitialViewController];
        
        [viewControllers addObject:nav];
        //[self addChildViewController:nav];
        
    }
    self.viewControllers = viewControllers;
    
//    UIViewController *firstVC = self.childViewControllers[0];
//    [self.view insertSubview:firstVC.view belowSubview:_tabbarView];
}

- (void)timerAction{
    
    AppDelegate *appDelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaweibo;
    
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
    
}

//number_notify_9.png  Timeline_Notice_color
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    //数据已经获取了 //32*32
    CGFloat tabBarButtonWidth = kWidth/4; //64    64-32
    
    
    if (_badgeView == nil) {
        _badgeView = [[ThemeImageView alloc] initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _badgeView.imgName =@"number_notify_9.png";
        [self.tabBar addSubview:_badgeView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        
        [_badgeView addSubview:_badgeLabel];
    }
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    if (count > 0 ) {
        
        _badgeView.hidden = NO;
        if (count >= 100) {
            count = 99;
        }
        
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
        
    }else{
        
        _badgeView.hidden = YES;
        
    }
    
    
}


@end
