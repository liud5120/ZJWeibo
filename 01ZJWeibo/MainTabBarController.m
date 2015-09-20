//
//  MainTabBarController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/19.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "MainTabBarController.h"

@implementation MainTabBarController
{
    UIImageView *tabbarView;
    UIImageView *selectImgView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _createSubVc];
    
}

- (void)_createSubVc{
    
    NSArray *names = @[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    
    NSMutableArray *navArray = [[NSMutableArray alloc]init];
    
    for (NSString *name in names) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        UINavigationController *nav = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:nav];
        
    }
    
    self.viewControllers = navArray;

    
}
@end
