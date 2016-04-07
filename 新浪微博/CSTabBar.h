//
//  CSTabBar.h
//  新浪微博
//
//  Created by 童乐 on 15/10/27.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSTabBar;
@protocol CSTabBarDelegate <UITabBarDelegate>
@optional
- (void) tabBarDidClickPlusButton:(CSTabBar *) tabBar;

@end
@interface CSTabBar : UITabBar
@property (nonatomic, assign) id<CSTabBarDelegate> delegate;

@end
