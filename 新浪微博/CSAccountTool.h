//
//  CSAccountTool.h
//  新浪微博
//
//  Created by 童乐 on 15/11/5.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSAccount;
@interface CSAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void) saveAccount:(CSAccount *) account;
/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (CSAccount *) account;
@end
