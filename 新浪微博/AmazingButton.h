//
//  AmazingButton.h
//  AmazingButton
//
//  Created by Wang on 14-8-20.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com


#import <UIKit/UIKit.h>
typedef enum{
    AmaButtonTypeNews,
//    AmaButtonTypeOrder,
//    AmaButtonTypeImage,
//    AmaButtonTypeVideo,
//    AmaButtonTypePost,
//    AmaButtonTypeAudio,
    AmaButtonTypeUser,
    AmaButtonTypeLocation,
    AmaButtonTypeMessage,
    AmaButtonTypeSetting,
    AmaButtonTypeFodder
} AmaButtonType;

@interface AmazingButton : UIControl
-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color type:(AmaButtonType)type;
-(void)show;
@end
