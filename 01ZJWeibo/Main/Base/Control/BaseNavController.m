//
//  BaseNavController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/19.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"

@interface BaseNavController ()

@end

@implementation BaseNavController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofication object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeDidChangeNofication object:nil];
    }
    
    return self;
}

- (void)loadImage{
    NSString *imageName = @"mask_titlebar64.png";
    ThemeManager *manage = [ThemeManager shareInstance];
    
    UIImage *bgImage = [manage getThemeImage:imageName];
    
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    UIColor *titleColor = [manage getThemeColor:@"Mask_Title_color"];
    titleColor = [UIColor blueColor];
    NSDictionary *attr = @{
                           NSForegroundColorAttributeName:titleColor
                          };
    
    self.navigationBar.titleTextAttributes = attr;
    
    self.navigationBar.tintColor = titleColor;
    
    UIImage *img = [manage getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadImage];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
