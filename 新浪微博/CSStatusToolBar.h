//
//  CSStatusToolBar.h
//  新浪微博
//
//  Created by 童乐 on 15/11/11.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSStatus;
@interface CSStatusToolBar : UIView
@property (nonatomic, strong) CSStatus *status;;
+ (instancetype) toolBar;
@end
