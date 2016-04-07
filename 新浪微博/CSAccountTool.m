
//
//  CSAccountTool.m
//  新浪微博
//
//  Created by 童乐 on 15/11/5.
//  Copyright © 2015年 童乐. All rights reserved.
//  处理所有和账号相关的操作

#define CSAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "CSAccountTool.h"
#import "CSAccount.h"
@implementation CSAccountTool
+ (void)saveAccount:(CSAccount *)account {
  

    //自定义对象的存储必须用NSKeyedArchiver，不再有writeToFile 方法
    [NSKeyedArchiver archiveRootObject:account toFile:CSAccountPath];
    //        [responseObject writeToFile:path atomically:YES];
}
+ (CSAccount *)account {
    
    //加载模型
    CSAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CSAccountPath];
    //验证账号是否过期
    long long exprires_in = [account.expires_in longLongValue];
    //获得过期时间
    NSDate *expriesTime = [account.created_time dateByAddingTimeInterval:exprires_in];
    //获取当前时间
    NSDate *now = [NSDate date];
    
    //如果now> = expriesTime 过期
    NSComparisonResult result =  [expriesTime compare:now];
    /*NSOrderedAscending = -1L, 升序  右边大于左边
     NSOrderedSame,
     NSOrderedDescending*/
    if (result == NSOrderedAscending || NSOrderedSame) {
        return nil;
    }
    
    return account;
}
@end
