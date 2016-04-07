//
//  CSComposeViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/11/15.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSComposeViewController.h"
#import "CSAccountTool.h"
#import "CSAccount.h"
#import "CSPlaceHolderTextView.h"
#import "AFNetworking.h"
#import "ProgressHUD.h"
#import "CSStatusBar.h"
#import "CSComposeToolBar.h"
#import "CSComposePhotoView.h"
#import "CSEmotionKeyboard.h"
@interface CSComposeViewController () <CSComposeToolBarDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak,nonatomic) CSPlaceHolderTextView *textView;
@property (nonatomic, weak) CSComposeToolBar *toolbar;
@property (nonatomic, weak) CSComposePhotoView *photoView;
@property (nonatomic, strong) CSEmotionKeyboard *emotionKeyboard;
/**是否正在切换键盘*/
@property (nonatomic, assign) BOOL switchingkeyboard;

@end
@implementation CSComposeViewController
- (CSEmotionKeyboard *)emotionKeyboard {
    if (_emotionKeyboard == nil) {
        self.emotionKeyboard = [[CSEmotionKeyboard alloc] init];
    }
    return _emotionKeyboard;
}
#pragma mark ******viewDidLoad*****
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];
    
    //设置输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolBar];
    
    //添加相册
    [self setupPhotoView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}
/**
 *  添加相册
 */
- (void) setupPhotoView {
    CSComposePhotoView *photoView = [[CSComposePhotoView alloc] init];
    self.photoView = photoView;
    photoView.y = 150;
    photoView.x = 10;
    photoView.width = self.view.width;
    photoView.height = self.view.height;
    [self.textView addSubview:photoView];
}
//当该对象销毁时 取消监听
- (void)dealloc {
    [CSNotificationCenter removeObserver:self];
}
//接收到通知后 解决键盘遮挡问题
- (void) keyBoardWillChangeFrame:(NSNotification *) noti {
    
    if (self.switchingkeyboard) return;
    
    //动画持续的时间
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    //键盘的frame
    CGRect kboardframe = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    //动画改变View的高度
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = kboardframe.origin.y - self.toolbar.height;
    }];
}


#pragma mark ******初始化textView******
- (void) setupToolBar {
    CSComposeToolBar *toolBar = [[CSComposeToolBar alloc] init];
    toolBar.delegate = self;
    self.toolbar = toolBar;
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    //设置在键盘顶部的内容
//    self.textView.inputAccessoryView = toolBar;
}
- (void) setupTextView {
    CSPlaceHolderTextView *textView =[[CSPlaceHolderTextView alloc] init];
    self.textView = textView;
    textView.delegate = self;
    //允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    
    //成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [textView becomeFirstResponder];
    
    
    //监听文本改变通知
    [CSNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void) setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancell)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
   
    
    
    NSString *name = [CSAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 100;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.textColor = [UIColor blackColor];
        titleView.numberOfLines = 0;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        
        //创建一个带有属性的字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        titleView.attributedText = attrStr;
        
        self.navigationItem.titleView = titleView;

    } else {
        self.title = prefix;
    }
}
#pragma mark ******监听方法******
/**
 *  监听文字改变
 */
- (void) textDidChange {
    
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void) cancell {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) send {
    //https://api.weibo.com/2/statuses/update.json
    //status true要发布的微博内容
    //pic false binary 微博的配图
    //access_token true
    //请求管理者
    if (self.photoView.photos.count) {
        [self sendWithImage];
    }else {
        [self sendWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) sendWithoutImage {
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    CSAccount *account = [CSAccountTool account];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    UIImage *image = [self.photoView.photos firstObject];
    params[@"pic"] = UIImageJPEGRepresentation(image, 1.0);
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    //发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
        [ProgressHUD show:@"微博发送成功"];
        [ProgressHUD dismiss];
    }
      failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
          CSLog(@"请求失败---%@",error);
          [ProgressHUD show:@"微博发送失败"];
          
      }];
    
}
- (void) sendWithImage{
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    CSAccount *account = [CSAccountTool account];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    NSString *url = @"https://api.weibo.com/2/statuses/upload.json";
    //发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photoView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [ProgressHUD show:@"微博发送成功"];
        [ProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        CSLog(@"请求失败---%@",error);
        [ProgressHUD show:@"微博发送失败"];

    }];

}
- (void) returnToNaV {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) switchKeyboard {
    CSEmotionKeyboard *keyboard = [[CSEmotionKeyboard alloc] init];
    if (self.textView.inputView == nil) { //切换为自定义键盘
        self.textView.inputView = keyboard;
        keyboard.width = self.view.width;
        keyboard.height = 260;
        self.toolbar.showEmotionkeyboard = NO;
    }else { //切换为系统自带的键盘
        self.textView.inputView = nil;
        self.toolbar.showEmotionkeyboard = YES;

    }
    //开始切换键盘
    self.switchingkeyboard = YES;
    
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time (DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];

    });
    [self.textView becomeFirstResponder];
    //结束切换
    self.switchingkeyboard = NO;
}
#pragma mark ******toolbar的代理方法******
- (void)composeToolBar:(CSComposeToolBar *)toolBar didToolBarBtnClicked:(CSComposeToolBarType) btnType{
    switch (btnType) {
        case CSComposeToolBarKeyboard://键盘
            [self openCamera];
            break;
        case CSComposeToolBarTrend://#
           
            break;
        case CSComposeToolBarPicture://相片
            [self openAlbum];
            break;
        case CSComposeToolBarMention://艾特
                        CSLog(@"@");
            break;
        case CSComposeToolBarEmoticon://表情
            [self switchKeyboard];
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.textView endEditing:YES];
}
#pragma mark 私有方法
/**
 *  打开系统相机
 */
- (void) openCamera {
    //如果相机不可用返回
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
//打开系统相册
- (void) openAlbum {
    //如果相册不可用返回
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark ******UIImagePickerControllerDelegate******
/**
 *  从UIImagePickerController选择完图片后就调用（拍照完毕活者选择相册图片完毕）
 *
 *  @param picker
 *  @param info   
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //info 中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photoView中
    [self.photoView addPhoto:image];
}
@end
