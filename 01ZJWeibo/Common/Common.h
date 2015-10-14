//
//  Common.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/19.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#ifndef _1ZJWeibo_Common_h
#define _1ZJWeibo_Common_h

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height

#define kAppKey             @"3385422392"
#define kAppSecret          @"bd3c14e6b6436a9f2b560593c1d0a574"
#define kAppRedirectURI     @"http://www.baidu.com"

//版本
#define kVersion [[UIDevice currentDevice].systemVersion floatValue]

//微博字体
#define FontSize_Weibo(isDetail) isDetail?16:15
#define FontSize_ReWeibo(isDetail) isDetail?15:14


#define unread_count @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
//#define home_timeline @"statuses/friends_timeline.json"  //微博列表
#define comments  @"comments/show.json"   //评论列表

#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)

#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈

#define nearby_timeline  @"place/nearby_timeline.json" //附近动态
#define userWeibo @"users/show.json"


#endif
