//
//  CSOAuthController.m
//  新浪微博
//
//  Created by 童乐 on 15/11/1.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSOAuthController.h"
#import "AFNetworking.h"
#import "CSNewFeatureController.h"
#import "CSTabBarViewController.h"
#import "CSAccount.h"
#import "ProgressHUD.h"
#import "CSAccountTool.h"
@interface CSOAuthController () <UIWebViewDelegate>

@end

@implementation CSOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview: webView];
    
    //用webview加载登陆页面(新浪提供)
    //请求地址 https://api.weibo.com/oauth2/authorize
    //请求参数
    /*
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2366429970&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL) webView:(UIWebView *) webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //获得url
    NSString *url =  request.URL.absoluteString;
    //判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        //截取code= 后面的参数值
        NSUInteger fromIndex = range.length + range.location;
        NSString *code = [url substringFromIndex:fromIndex];
        
        //利用code换取accessToken
        [self accessTokenWithCode:code];
       
    }
    //禁止加载回调地址
    return YES;
}
#pragma mark ******webView代理方法******
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [ProgressHUD show:@"正在加载..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [ProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [ProgressHUD dismiss];
}
/**
 *  利用code(授权成功后的requesttoken) 换取一个accesstoken
 *
 *  @param code 授权成功后的requesttoken
 */
- (void) accessTokenWithCode:(NSString *) code {
    /*
     请求参数
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2366429970";
    params[@"client_secret"] = @"67d9cc062793eccb7466ade40f92b081";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://";
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    //发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
         [ProgressHUD dismiss];
    
        //将返回的账号数据转成模型 再存进沙盒
        CSAccount *account = [CSAccount accountWithDic:responseObject];
        //存储账号信息
        [CSAccountTool saveAccount:account];
        
        //切换窗口的根控制器
        [UIWindow switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         [ProgressHUD dismiss];
        CSLog(@"请求失败---%@",error);
    }];
}
@end
