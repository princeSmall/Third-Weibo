//
//  CSStatusBar.h
//  新浪微博
//
//  Created by 童乐 on 15/11/16.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSStatusBar : UIWindow
@property (nonatomic, copy) UILabel *statusMsgLbl;

- (void)showStatus:(NSString *)statusMsg ;
- (void) dismiss;
@end
