//
//  CSStatus.h
//  新浪微博
//
//  Created by 童乐 on 15/11/7.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSUser;
@interface CSStatus : NSObject

/**user	object	微博作者的用户信息字段*/
@property (nonatomic, strong) CSUser *user;
/**text	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/**idstr	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/**微博创建时间*/
@property (nonatomic, copy) NSString *created_at;
/**微博来源*/
@property (nonatomic, copy) NSString *source;
/**配图数组*/
@property (nonatomic, strong) NSArray *pic_urls;
/**转发的微博*/
@property (nonatomic, strong) CSStatus *retweeted_status;
/**转发数*/
@property (nonatomic, assign) int reposts_count;
/**评论数*/
@property (nonatomic, assign) int comments_count;
/**表态数*/
@property (nonatomic, assign) int attitudes_count;






@end
