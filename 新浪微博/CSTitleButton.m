
//
//  CSTitleButton.m
//  新浪微博
//
//  Created by 童乐 on 15/11/5.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSTitleButton.h"

@implementation CSTitleButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置按钮选中和非选中图片
        [self  setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //如果仅仅是调整按钮内部的位置 那么在layoutSubviews中单独设置位置即可
    //计算titlelabel的frame
    self.titleLabel.x = self.imageView.x - 20;
    
    //计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
@end
