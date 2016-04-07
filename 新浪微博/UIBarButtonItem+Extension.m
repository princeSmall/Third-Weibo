
//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param action    点击item后调用target的哪个方法
 *  @param image     普通图片
 *  @param highImage 高亮图片
 *  @param target    点击item后调用哪个对象的方法
 *  @return 一个item
 */
+ (UIBarButtonItem *) itemWithtarget:(id)target Action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    //自定义按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置尺寸
    //将当前图片的尺寸赋给按钮
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
