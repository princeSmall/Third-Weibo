//
//  CSUser.h
//  新浪微博
//
//  Created by 童乐 on 15/11/7.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum  {
    CSUserVerifiedTypeNone = -1, //没有任何认证
    CSUserVerifiedTypePersonal = 0, //个人认证
    CSUserVerifiedTypeEnterprisce = 2, //企业官方
    CSUserVerifiedTypeMedia = 3,//媒体官方
    CSUserVerifiedTypeWebsite = 5,//网站官方
    CSUserVerifiedTypeDaren = 220//微博达人
}CSUserVerifiedType;
@interface CSUser : NSObject

/** name	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;
/**  idstr	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/** profile_image_url	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;
/**会员类型 值大于2 才代表会员*/
@property (nonatomic, assign) int mbtype;
/**会员等级*/
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign,getter=isVip) BOOL vip;

@property (nonatomic, assign) CSUserVerifiedType verified_type;

@end
