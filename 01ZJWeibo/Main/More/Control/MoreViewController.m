//
//  MoreViewController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/19.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"
#import "AppDelegate.h"


static NSString *moreCellId =@"moreCellId";

@interface MoreViewController ()
{
    UITableView *_tableView;
    //NSArray *_arrayM;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _arrayM = [[NSArray alloc]init];
//    _arrayM = @[@"主题选择",@"账户管理",@"意见反馈",@"",@"登出当前账号"];
    
    [self _createTableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [_tableView reloadData];
}

- (void)_createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    _tableView.backgroundColor= [UIColor clearColor];
    
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.themeImageView.imgName = @"more_icon_theme.png";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManager shareInstance].themeName;
        }
        else if(indexPath.row == 1) {
            cell.themeImageView.imgName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }
    else if(indexPath.section == 1) {
        cell.themeTextLabel.text = @"意见反馈";
        cell.themeImageView.imgName = @"more_icon_feedback.png";
    }
    else if(indexPath.section == 2) {
        cell.themeTextLabel.text = @"登出当前账号";
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.themeTextLabel.center = cell.contentView.center;
    }
    
    //设置箭头
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        ThemeTableViewController *vc = [[ThemeTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES ];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认登出么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        
        [alert show];
        
        
        
    }
 
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        
        [appDelegate.sinaweibo logOut];
    }
    
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
