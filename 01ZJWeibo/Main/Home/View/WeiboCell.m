//
//  WeiboCell.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/24.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "WeiboModel.h"
#import "Utils.h"
#import "WeiboView.h"
#import "ThemeManager.h"


@implementation WeiboCell


- (void)awakeFromNib {
    

    
    self.weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.weiboView];
    
    self.backgroundColor = [UIColor clearColor];
    
    
    //设置主题颜色
    self.userName.colorName =@"Timeline_Name_color";
    self.commentCountLabel.colorName = @"Timeline_Name_color";
    self.repostCountLabel.colorName = @"Timeline_Name_color";
    self.createTime.colorName =@"Timeline_Name_color";
    self.soureLabel.colorName = @"Timeline_Name_color";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setModel:(WeiboModel *)model{
    
    
-(void)setLayoutFrame:(WeiboViewLaoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame=layoutFrame;
        [self setNeedsLayout];
    }
}


- (void)layoutSubviews{


    
    [super layoutSubviews];
    
    WeiboModel *model = self.layoutFrame.weiboModel;
    
    
    
    NSString *urlStr =  model.userModel.profile_image_url;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    self.userName.text = model.userModel.screen_name;
    self.repostCountLabel.text = [NSString stringWithFormat:@"转发：%@",model.repostsCount];
    self.commentCountLabel.text = [NSString stringWithFormat:@"评论：%@",model.commentsCount];

    self.createTime.text = [Utils weiboDateString:model.createDate];
    
    //weiboView设置
    self.weiboView.layoutFrame =self.layoutFrame;
    self.weiboView.frame = self.layoutFrame.frame;

    self.soureLabel.text = model.source;
    
    

}
@end
