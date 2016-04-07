//
//  CSUser.m
//  新浪微博
//
//  Created by 童乐 on 15/11/7.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSUser.h"

@implementation CSUser
//- (BOOL)isVip{
//    return self.mbrank > 2;
//}
- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    self.vip = mbtype>2;
}
@end
