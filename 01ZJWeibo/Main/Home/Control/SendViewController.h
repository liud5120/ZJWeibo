//
//  SendViewController.h
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/31.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "FaceScrollView.h"

@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZoomImageViewDelegate,CLLocationManagerDelegate,FaceViewDelegate>{
    
    //1 文本编辑栏
    UITextView *_textView;
    
    
    //2 工具栏
    UIView *_editorBar;
    
    
    //3 显示缩略图
    ZoomImageView *_zoomImageView;
    
    CLLocationManager *_locationManager;
    UILabel *_locationLabel;
    
    
    
    UIImage *_sendImage;
    
    FaceScrollView *_faceViewPanel;

}

@end
