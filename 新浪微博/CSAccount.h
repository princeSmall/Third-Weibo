//
//  CSAccount.h
//  新浪微博
//
//  Created by 童乐 on 15/11/2.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSAccount : NSObject <NSCoding>
/*
 "access_token" = "2.001wXBtC1XSJaCbebdd166320ZpUjH";
 
 "expires_in" = 157679999;
 
 "remind_in" = 157679999;
 
 uid = 2645332940;
 */
/**用于调用access_token接口获取授权后的accesstoken*/
@property (nonatomic, copy) NSString *access_token;
/**access_token的生命周期，单位秒*/
@property (nonatomic, copy) NSString *expires_in;
/**当前授权用户的UID*/
@property (nonatomic, copy) NSString *uid;
/**当前授权用户的昵称*/
@property (nonatomic, copy) NSString *name;
/**账号的创建时间*/
@property (nonatomic, strong) NSDate *created_time;
+ (instancetype) accountWithDic:(NSDictionary *) dic;
@end
