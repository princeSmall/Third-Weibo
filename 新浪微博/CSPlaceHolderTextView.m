//
//  CSPlaceHolderTextView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/15.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSPlaceHolderTextView.h"

@implementation CSPlaceHolderTextView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //通知 object是谁去监听
        [CSNotificationCenter
         addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  监听文字改变
 */
- (void) textDidChange {
    //重绘 重新调用drawrect
    [self setNeedsDisplay];
}
- (void) drawRect:(CGRect)rect {
    //如果有输入文字 直接返回 不画占位文字
    if (self.hasText) return;
    
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = self.font;
        attrs[NSForegroundColorAttributeName] = self.placeholderColor;
        [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)dealloc {
    [CSNotificationCenter removeObserver:self];
}
@end
