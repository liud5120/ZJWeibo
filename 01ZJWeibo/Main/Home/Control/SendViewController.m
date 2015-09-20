//
//  SendViewController.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/31.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "MMDrawerController.h"
#import "DataService.h"

#import <CoreLocation/CoreLocation.h>


@interface SendViewController ()
{
    

}
@end

@implementation SendViewController
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return  self;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createNavItems];
    [self _createEditorViews];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
    //弹出键盘
    [_textView becomeFirstResponder];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent =NO;
    _textView.frame = CGRectMake(0, 0, kWidth, 120);
    _textView.contentInset= UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_textView becomeFirstResponder];
}

#pragma  mark - 创建子视图
- (void)_createNavItems{
    //1.关闭按钮
    ThemeButton *closeButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.normalImgName = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    
    //2.发送按钮
    ThemeButton *sendButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.normalImgName = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:sendItem];
    
}

- (void)_createEditorViews{
    
    //1 文本输入视图
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 0)];
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = YES;
    
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_textView];
    
    //2 编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, 55)];
    _editorBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_editorBar];
    //3.创建多个编辑按钮
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];
    for (int i=0; i<imgs.count; i++) {
        NSString *imgName = imgs[i];
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(15+(kWidth/5)*i, 20, 40, 33)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+i;
        button.normalImgName = imgName;
        [_editorBar addSubview:button];
    }
    
}

- (void)buttonAction:(UIButton*)button{
    if (button.tag == 10) {
        [self _selectPhoto];
    }else if(button.tag == 13)
    {
        [self _location];
        
    }  else if(button.tag == 14) {  //显示、隐藏表情
        
        BOOL isFirstResponder = _textView.isFirstResponder;
        
        //输入框是否是第一响应者，如果是，说明键盘已经显示
        if (isFirstResponder) {
            //隐藏键盘
            [_textView resignFirstResponder];
            //显示表情
            [self _showFaceView];
            //隐藏键盘
            
        } else {
            //隐藏表情
            [self _hideFaceView];
            
            //显示键盘
            [_textView becomeFirstResponder];
        }
        
    }
    
    
}


#pragma mark - 表情处理

- (void)_showFaceView{
    
    //创建表情面板
    if (_faceViewPanel == nil) {
        
        
        _faceViewPanel = [[FaceScrollView alloc] init];
        [_faceViewPanel setFaceViewDelegate:self];
        //放到底部
        _faceViewPanel.top  = kHeight-64;
        [self.view addSubview:_faceViewPanel];
    }
    
    //显示表情
    [UIView animateWithDuration:0.3 animations:^{
        
        _faceViewPanel.bottom = kHeight-64;
        //重新布局工具栏、输入框
        _editorBar.bottom = _faceViewPanel.top;
        
    }];
}

//隐藏表情
- (void)_hideFaceView {
    
    //隐藏表情
    [UIView animateWithDuration:0.3 animations:^{
        _faceViewPanel.top = kHeight-64;
        
    }];
    
}


- (void)faceDidSelect:(NSString *)text{
    NSMutableString *mString=[[NSMutableString alloc]initWithString:_textView.text];
    
    _textView.text= [mString stringByAppendingString:text];
    
}


- (void)_location
{
    
    if (_locationManager == nil ) {
        _locationManager = [[CLLocationManager alloc]init];
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//设置精确定位
    _locationManager.delegate =self;
    [_locationManager startUpdatingLocation];
    
}

//代理获取定位数据
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"3");
    
    [_locationManager stopUpdatingLocation];
    //取得位置信息
    CLLocation *location = [locations lastObject];
    
    
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度%lf纬度%lf",coordinate.longitude,coordinate.latitude);
    
    
    
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:coordinateStr forKey:@"coordinate"];
    
    __weak SendViewController *weakSelf =self;
    
    [DataService requestAFUrl:@"location/geo/geo_to_address.json" httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSLog(@"%@",result);
        
        __strong SendViewController *strongSelf = weakSelf;
        
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count>0) {
            NSDictionary *geo = [geos lastObject];
            
            NSString *addr = [geo objectForKey:@"address"];
            NSLog(@"%@",addr);
            
            strongSelf->_locationLabel.hidden = NO;
            strongSelf->_locationLabel.text = addr;
            strongSelf->_locationLabel.hidden = strongSelf->_editorBar.top;
        }
        
    }];
    
    
    //二 IOS 自己内置
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
    }];
}


- (void)sendAction{
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容为空";
    }
    else if(text.length > 140) {
        error = @"微博内容大于140字符";
    }
    
    if (error != nil) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    
    //发送
    AFHTTPRequestOperation *operation =  [DataService sendWeibo:text image:_sendImage block:^(id result) {
        NSLog(@"发送成功");
        //状态栏显示
        [self showStatusTip:@"发送成功" show:NO operation:nil];
        
    }];
    
    [self showStatusTip:@"正在发送..." show:YES operation:operation];
    
    [self closeAction];

    
    
    
}

- (void)closeAction{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        
        [mmDrawer closeDrawerAnimated:YES completion:NULL];
    }
    
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}



#pragma mark - 键盘弹出通知

- (void)keyBoardWillShow:(NSNotification *)notification{
    
//    NSLog(@"%@",notification);
    //1 取出键盘frame
    NSValue *bounsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    
    CGRect frame = [bounsValue CGRectValue];
    //2 键盘高度
    //CGFloat height = frame.size.height;
    //_editorBar.bottom = kHeight -height -60;
    
    _editorBar.bottom = frame.origin.y - 64;
}

#pragma mark -选择照片
- (void)_selectPhoto{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    //选择相机 或者 相册
    if (buttonIndex == 0) {
        
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
    }else if(buttonIndex == 1){
        
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }else{
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //弹出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //2 取出照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //3 显示缩略图
    
    if (_zoomImageView == nil) {
        _zoomImageView = [[ZoomImageView alloc]initWithImage:image];
        _zoomImageView.frame = CGRectMake(10, _textView.bottom+10, 80, 80);
        [self.view addSubview:_zoomImageView];
        
        _zoomImageView.delegate = self;
    }
    _zoomImageView.image = image;
    _sendImage = image;
}

#pragma mark - 放大缩小图片 代理

//当图片放大时候键盘隐藏,缩小的时候键盘恢复
- (void)imageWillZoomOut:(ZoomImageView *)imageView{
    
    [_textView becomeFirstResponder];
    
}
- (void)imageWillZoomIn:(ZoomImageView *)imageView{
    [_textView resignFirstResponder];
    
}


@end
