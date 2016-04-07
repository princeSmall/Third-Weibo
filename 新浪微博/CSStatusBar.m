//
//  CSStatusBar.m
//  新浪微博
//
//  Created by 童乐 on 15/11/16.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSStatusBar.h"
#define windowBounds [UIScreen mainScreen].bounds
@implementation CSStatusBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor blackColor];
        //提高自定义状态栏的级别
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        

        
        _statusMsgLbl = [[UILabel alloc] initWithFrame:self.frame];
        _statusMsgLbl.backgroundColor = [UIColor clearColor];
        _statusMsgLbl.textColor = [UIColor whiteColor];
        _statusMsgLbl.font = [UIFont systemFontOfSize:10.0f];
        _statusMsgLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusMsgLbl];
    }
    return self;
}
- (void) showStatus:(NSString *) statusMsg {
  
    self.hidden = NO;
    self.alpha = 1.0f;
    self.statusMsgLbl.text = @"";
    self.frame = CGRectMake(0, 0, 320, 10);
//    CGSize totalSize = self.frame.size;
    
//    self.statusMsgLbl.text = statusMsg;

    [UIView animateWithDuration:2.0f animations:^{
        
            } completion:^(BOOL finished){
        self.statusMsgLbl.text = statusMsg;
    }];
}
- (void) dismiss {
    self.alpha = 1.0f;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        self.statusMsgLbl.text = @"";
        self.hidden = YES;
    }];;
}
- (void)dealloc
{
    [_statusMsgLbl removeFromSuperview];
    
}
@end
