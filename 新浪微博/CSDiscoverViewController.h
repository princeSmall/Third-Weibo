//
//  CSDiscoverViewController.h
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "IWBasicSettingViewController.h"

@interface CSDiscoverViewController : IWBasicSettingViewController
//滚动视图对象、视图小圆点对应的页码、冬天数组对象存储图片
@property (retain,nonatomic)UIScrollView * scrollView;
@property (retain,nonatomic)UIPageControl * pageController;
@property (retain,nonatomic)NSMutableArray * images;

@end
