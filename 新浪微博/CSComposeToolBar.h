//
//  CSComposeToolBar.h
//  新浪微博
//
//  Created by 童乐 on 15/11/16.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CSComposeToolBarKeyboard,//键盘
    CSComposeToolBarTrend,//潮流
    CSComposeToolBarPicture,//相片
    CSComposeToolBarMention,//提及
    CSComposeToolBarEmoticon//表情
}CSComposeToolBarType;
@class CSComposeToolBar;
@protocol CSComposeToolBarDelegate <NSObject>

- (void) composeToolBar:(CSComposeToolBar *) toolBar didToolBarBtnClicked:(CSComposeToolBarType) btnType;

@end
@interface CSComposeToolBar : UIView
@property (nonatomic, assign) id<CSComposeToolBarDelegate> delegate;
@property (nonatomic, assign) BOOL showEmotionkeyboard;

@end
