//
//  AppDelegate.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "AppDelegate.h"
#import "CSTabBarViewController.h"
#import "CSNewFeatureController.h"
#import "CSOAuthController.h"
#import "CSAccount.h"
#import "CSAccountTool.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *mySetting = [UIUserNotificationSettings settingsForTypes:myType categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySetting];
    }else{
        UIRemoteNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myType];
    }
    //创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [[UIScreen mainScreen] bounds];
  
    //显示窗口
    [self.window makeKeyAndVisible];
    
    //设置根控制器
    CSAccount *account = [CSAccountTool account];
    CSLog(@"%@",account.uid);
    
    if (account) {//之前已经登录过了
        [UIWindow switchRootViewController];
    } else {
        self.window.rootViewController = [[CSOAuthController alloc] init];
    }
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

/**
 *  当程序进入后台时工作
 *
 *  @param application <#application description#>
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
   //向操作系统申请后台运行资格
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
       //当申请的后台运行时间已经结束 就会调用这个block
        //结束任务
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 *  图片过多时 清除内存
 *
 *  @param application <#application description#>
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    //取消下载
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //清除内存中的图片
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
}
@end
