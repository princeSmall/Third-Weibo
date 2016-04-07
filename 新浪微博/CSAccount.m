//
//  CSAccount.m
//  新浪微博
//
//  Created by 童乐 on 15/11/2.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSAccount.h"

@implementation CSAccount
/*
 "access_token" = "2.001wXBtC1XSJaCbebdd166320ZpUjH";
 
 "expires_in" = 157679999;
 
 "remind_in" = 157679999;
 
 uid = 2645332940;
 */
+ (instancetype) accountWithDic:(NSDictionary *) dic {
    
    CSAccount *account = [[self alloc] init ];
    //获得账号存储的时间(accessToken的产生时间)
    account.created_time = [NSDate date];
    account.access_token = [dic objectForKey:@"access_token"];
    account.expires_in = [dic objectForKey:@"expires_in"];
    account.uid = [dic objectForKey:@"uid"];

    return account;
}
/**
 *  当一个对象要归档进沙盒时 就会调用这个方法
 *  目的：说明这个对象的那些属性要进沙盒
 *  @param aCoder
 */
- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];

}
/**
 *  当从沙盒中解档一个对象时调用该方法
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
