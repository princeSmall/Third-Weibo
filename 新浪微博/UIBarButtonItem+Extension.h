//
//  UIBarButtonItem+Extension.h
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *) itemWithtarget:(id) target Action:(SEL) action image:(NSString *) image highImage:(NSString *) highImage;
@end
