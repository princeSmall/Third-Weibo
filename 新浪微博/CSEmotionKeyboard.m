//
//  CSEmotionKeyboard.m
//  新浪微博
//
//  Created by 童乐 on 15/11/19.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSEmotionKeyboard.h"
#import "CSEmotionTabar.h"
#import "CSEmotionListView.h"
#import "CSEmotion.h"

@interface CSEmotionKeyboard () <CSEmotionTabarDelegate>
@property (strong,nonatomic) CSEmotionListView *recentListView;
@property (strong,nonatomic) CSEmotionListView *defaultListView;
@property (strong,nonatomic) CSEmotionListView *emojiListView;
@property (strong,nonatomic) CSEmotionListView *lxhListView;
@property (nonatomic, weak) CSEmotionTabar *tabar;
///**容纳表情内容的View*/
//@property (nonatomic, weak) UIView *contentView;
/**保存正在显示的listView*/
@property (nonatomic, weak) CSEmotionListView *showingListView;




@end
@implementation CSEmotionKeyboard
#pragma mark ******懒加载******
- (CSEmotionListView *)recentListView {
    if (!_recentListView) {
        self.recentListView = [[CSEmotionListView alloc] init];

    }
    return _recentListView;
}
- (CSEmotionListView *)defaultListView {
    if (!_defaultListView) {
        self.defaultListView = [[CSEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultEmotions = [CSEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.defaultListView.emotions = defaultEmotions;

    }
    return _defaultListView;
}
- (CSEmotionListView *)emojiListView {
    if (!_emojiListView) {
        self.emojiListView = [[CSEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions = [CSEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.emotions = emojiEmotions;
    }
    return _emojiListView;
}
- (CSEmotionListView *)lxhListView {
    if (!_lxhListView) {
        self.lxhListView = [[CSEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [CSEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.emotions = lxhEmotions;
    }
    return _lxhListView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //表情内容
//        UIView *contentView = [[UIView alloc] init];
//        self.contentView = contentView;
//        [self addSubview:contentView];
        
        
        //tabbar
        CSEmotionTabar *tabar = [[CSEmotionTabar alloc] init];
        tabar.delegate = self;
        self.tabar = tabar;
        [self addSubview:tabar];

        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //正在显示的showinglistView尺寸
    self.showingListView.x = 0;
    self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.height - self.tabar.height;
    
    
    //tabar
    self.tabar.height = 44;
    self.tabar.width = self.width;
    self.tabar.x = 0;
    self.tabar.y = self.height - self.tabar.height;

}
- (void)emotionTabbar:(CSEmotionTabar *)taber didSelectButton:(CSEmotionTabbarButtonType)butonType {
    //移除contentView之前显示的控件
//    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //移除键盘正在显示的控件
    [self.showingListView removeFromSuperview];
    switch (butonType) {
        case CSEmotionTabbarButtonDefault:  {//默认
            [self addSubview:self.defaultListView];
            //谁在显示 就赋值给showinglistView
            self.showingListView = self.defaultListView;
        }
            break;
        
        case CSEmotionTabbarButtonRecent: {//最近
            [self addSubview:self.recentListView];
            self.showingListView = self.recentListView;

        }
            break;
        case CSEmotionTabbarButtonEmoji: { //emoji
            [self addSubview:self.emojiListView];
            self.showingListView = self.emojiListView;

        }
            break;
        case CSEmotionTabbarButtonLxh:  { //浪小花
            [self addSubview:self.lxhListView];
            self.showingListView = self.lxhListView;

            
            break;
        }
        default:
            break;
    }
    //设置frame 相当于调用layoutSubviews
    [self setNeedsLayout];
}
@end
