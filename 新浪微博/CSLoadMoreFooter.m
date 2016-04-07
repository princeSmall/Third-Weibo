//
//  CSLoadMoreFooter.m
//  新浪微博
//
//  Created by 童乐 on 15/11/8.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSLoadMoreFooter.h"

@interface CSLoadMoreFooter ()

@end

@implementation CSLoadMoreFooter
+ (instancetype) initWithLoadMoreFooter {
    return [[[NSBundle mainBundle] loadNibNamed:@"CSLoadMoreFooter" owner:self options:nil] lastObject];
}


@end
