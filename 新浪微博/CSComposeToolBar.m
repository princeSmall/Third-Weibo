//
//  CSComposeToolBar.m
//  新浪微博
//
//  Created by 童乐 on 15/11/16.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSComposeToolBar.h"
@interface CSComposeToolBar()
@property (nonatomic,weak) UIButton *emotionButton;
@end
@implementation CSComposeToolBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //键盘
        [self setupBtn:@"compose_keyboardbutton_background" highImage:@"compose_keyboardbutton_background_highlighted" type:CSComposeToolBarKeyboard];
        //热门
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:CSComposeToolBarTrend];
        //图片
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:CSComposeToolBarPicture];
        //提及
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:CSComposeToolBarMention];
         //表情
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:CSComposeToolBarEmoticon];
    }
    return self;
}
- (UIButton *) setupBtn:(NSString *) image highImage:(NSString *) highImage type:(CSComposeToolBarType) type{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}
- (void) btnClicked:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didToolBarBtnClicked:)]) {
        NSUInteger index = (NSUInteger) (sender.x/sender.width);
        [self.delegate composeToolBar:self didToolBarBtnClicked:index];
    }
}

- (void)setShowEmotionkeyboard:(BOOL)showEmotionkeyboard {
    _showEmotionkeyboard = showEmotionkeyboard;
    
    if (showEmotionkeyboard) {
        //显示键盘图标
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    CGFloat x = 0;
    CGFloat w = self.width / 5;
    CGFloat h = self.height;
    for (int i = 0; i < count; i ++ ) {
        UIButton *btn =  self.subviews[i];
        x = i  * w;
        btn.frame = CGRectMake(x, 0 , w, h);
    }
    
}
@end
