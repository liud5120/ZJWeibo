//
//  WeiboAnnotationView.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/9/3.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboAnnotation.h"
#import "WeiboModel.h"

@interface WeiboAnnotationView : MKAnnotationView{
    
    UIImageView *_userHeadImageView;//头像图片
    UILabel *_textLabel;//微博内容
}

@end
