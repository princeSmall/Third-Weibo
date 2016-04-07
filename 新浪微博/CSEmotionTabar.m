//
//  CSEmotionTabar.m
//  新浪微博
//
//  Created by 童乐 on 15/11/19.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSEmotionTabar.h"
#import "CSEmotionTabbarButton.h"
@interface CSEmotionTabar ()
@property (weak,nonatomic) CSEmotionTabbarButton *selectdBtn;
@end
@implementation CSEmotionTabar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupBtn:@"最近" buttonType:CSEmotionTabbarButtonRecent];
        [self setupBtn:@"默认" buttonType:CSEmotionTabbarButtonDefault];
        [self setupBtn:@"Emoji" buttonType:CSEmotionTabbarButtonEmoji];
        [self setupBtn:@"浪小花" buttonType:CSEmotionTabbarButtonLxh];
    }
    return self;
}
- (CSEmotionTabbarButton *) setupBtn:(NSString *) title buttonType:(CSEmotionTabbarButtonType) type{
    CSEmotionTabbarButton *btn = [[CSEmotionTabbarButton alloc] init];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    //设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    
    
    //设置背景
    [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    
    btn.highlighted = NO;
    [self addSubview:btn];
    
    return  btn;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置按钮的frame
    int btnCount = (int)self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        CSEmotionTabbarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }

}
- (void) btnClicked:(CSEmotionTabbarButton *) sender {
    //取消之前按钮的选中状态
    self.selectdBtn.selected = NO;
    //当前按钮选中为yes
    sender.selected = YES;
    self.selectdBtn = sender;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabbar:didSelectButton:)]) {
        [self.delegate emotionTabbar:self didSelectButton:sender.tag];
    }
}

- (void)setDelegate:(id<CSEmotionTabarDelegate>)delegate {
    _delegate = delegate;
    
    //设置默认选中按钮

        [self btnClicked:(CSEmotionTabbarButton *)[self viewWithTag:CSEmotionTabbarButtonDefault]];
    
    
}
@end
