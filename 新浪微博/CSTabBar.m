//
//  CSTabBar.m
//  新浪微博
//
//  Created by 童乐 on 15/10/27.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSTabBar.h"

@interface CSTabBar ()
@property (weak,nonatomic) UIButton *plusBtn;
@end
@implementation CSTabBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  加号按钮点击
 */
- (void) plusBtnClick {
    if([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
    //设置加号按钮的位置
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.centerY = self.height*0.5;
    CGFloat tabbarButtonW = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count ; i ++) {
        //拿出tabbar中的所有子控件
        UIView *child = self.subviews[i];
        //UITabBarButton 是苹果私有的 可以将字符串转成类名
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            
            tabbarButtonIndex ++ ;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
        
    }
}

@end
