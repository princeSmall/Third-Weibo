//
//  CSEmotionTabbarButton.m
//  新浪微博
//
//  Created by 童乐 on 15/11/22.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSEmotionTabbarButton.h"

@implementation CSEmotionTabbarButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
//重写该方法次方就会失效
- (void)setHighlighted:(BOOL)highlighted {
    
}
@end
