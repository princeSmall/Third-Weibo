
//
//  UIWindow+Extension.m
//  新浪微博
//
//  Created by 童乐 on 15/11/5.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "CSNewFeatureController.h"
#import "CSTabBarViewController.h"
@implementation UIWindow (Extension)
+ (void)switchRootViewController {
    //上一次的使用版本 ,存储在沙盒中的版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号 从info.plist中获取
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        //版本号相同
        window.rootViewController = [[CSTabBarViewController alloc] init];
    } else {
        window.rootViewController = [[CSNewFeatureController alloc] init];
        //将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立马将版本号存入内存
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


}
@end
