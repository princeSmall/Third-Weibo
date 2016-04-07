//
//  CSEmotionPageView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/24.
//  Copyright © 2015年 童乐. All rights reserved.
//  用来表示一页表情（显示1~20个表情）

#import "CSEmotionPageView.h"
#import "CSEmotion.h"
/**一页最多7列*/
#define CSEmotionMaxCols 7
/**一页最多3行*/
#define CSEmotionMaxRows 3
@interface CSEmotionPageView ()
@property (weak,nonatomic) UIButton *deleteBtn;
@end
@implementation CSEmotionPageView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        UIButton *deleteBtn = [[UIButton alloc] init];
//        self.deleteBtn = deleteBtn;
//        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
//        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
//        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:deleteBtn];
     
    }
    return self;
}
- (void) deleteClick {
    
}
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i ++ ) {
        UIButton *btn = [[UIButton alloc] init];
        CSEmotion *emotion = emotions[i];
        [self addSubview:btn];
        if(emotion.png) {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];

        } else if(emotion.code){
            //将16进制的emoji转成图片
            NSString *emoji = [emotion.code emoji];
            [btn setTitle:emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
            
        }
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.emotions.count;
    //内边距
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2*inset)/CSEmotionMaxCols;
    CGFloat btnH = (self.height - inset)/CSEmotionMaxRows;
    for (int i = 0; i < count; i ++ ) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = (i%CSEmotionMaxCols) * btnW + inset;
        btn.y = (i/CSEmotionMaxCols) * btnH + inset;
    }
    // 删除按钮
//    self.deleteBtn.width = btnW;
//    self.deleteBtn.height = btnH;
//    self.deleteBtn.y = self.height - btnH;
//    self.deleteBtn.x = self.width - inset - btnW;
}
/**
 *  监听表情按钮点击按钮
 *
 *  @param btn
 */
- (void) btnClick:(UIButton *) btn {
    
}
@end
