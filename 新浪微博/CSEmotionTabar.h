//
//  CSEmotionTabar.h
//  新浪微博
//
//  Created by 童乐 on 15/11/19.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CSEmotionTabbarButtonRecent, //最近
    CSEmotionTabbarButtonDefault, //默认
    CSEmotionTabbarButtonEmoji,//emoji
    CSEmotionTabbarButtonLxh //浪小花
}CSEmotionTabbarButtonType;
@class CSEmotionTabar;
@protocol CSEmotionTabarDelegate <NSObject>

- (void) emotionTabbar:(CSEmotionTabar *)taber didSelectButton:(CSEmotionTabbarButtonType) butonType;

@end
@interface CSEmotionTabar : UIView
@property (nonatomic, assign) id<CSEmotionTabarDelegate> delegate;

@end
