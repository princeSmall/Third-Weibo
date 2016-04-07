//
//  CSEmotion.h
//  新浪微博
//
//  Created by 童乐 on 15/11/23.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSEmotion : NSObject
/**表情的文字描述*/
@property (nonatomic, copy) NSString *chs;
/**表情的png图片名称*/
@property (nonatomic, copy) NSString *png;
/**emoji的16进制编码*/
@property (nonatomic, copy) NSString *code;

@end
