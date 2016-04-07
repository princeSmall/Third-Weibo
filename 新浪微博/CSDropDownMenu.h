//
//  CSDropDownMenu.h
//  新浪微博
//
//  Created by 童乐 on 15/10/25.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSDropDownMenu;
@protocol CSDropDownMenuDelegate <NSObject>

- (void) dropDownMenuDidDismiss:(CSDropDownMenu *) menu;

- (void) dropDownMenuDidShow:(CSDropDownMenu *) menu;

@end
@interface CSDropDownMenu : UIView
@property (nonatomic, assign) id<CSDropDownMenuDelegate> delegate;


+ (instancetype) menu;

- (void) showFrom:(UIView *) from;
- (void) dismiss;
/**
 *  内容
 */
@property (nonatomic, strong) UIView *conten;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contenController;
@end
