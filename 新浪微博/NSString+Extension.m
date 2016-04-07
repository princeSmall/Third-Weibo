
//
//  NSString+Extension.m
//  新浪微博
//
//  Created by 童乐 on 15/11/5.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
//返回字符串所占用的尺寸.

- (CGSize) sizeWithFont:(UIFont *) font maxW:(CGFloat) maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize) sizeWithFont:(UIFont *) font {
    return  [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
