//
//  CommentModel.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/29.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "CommentModel.h"
#import "Utils.h"

@implementation CommentModel

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    self.user = user;
    
    NSDictionary *status = [dataDic objectForKey:@"status"];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:status];
    self.weibo = weibo;
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic != nil) {
        CommentModel *sourceComment = [[CommentModel alloc] initWithDataDic:commentDic];
        self.sourceComment = sourceComment;
    }
    
    //处理评论中的表情
    self.text = [Utils parseTextImage:_text];
    
}

@end