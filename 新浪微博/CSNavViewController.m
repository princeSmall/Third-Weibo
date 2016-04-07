//
//  CSNavViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSNavViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface CSNavViewController ()

@end

@implementation CSNavViewController

+ (void) initialize {
    //设置所有item的主题样式
    UIBarButtonItem *item =  [UIBarButtonItem appearance];
   
    //普通状态
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    textDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textDic forState:UIControlStateNormal];
   
    //不可点击状态
    NSMutableDictionary *disableTextDic = [NSMutableDictionary dictionary];
    disableTextDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disableTextDic forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  能够拦截所有push进来的控制器
 *  统一设置导航栏的样式
 *  @param viewController  即将push进来的viewcontroller
 */
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
    //如果push进来的不是根控制器，才创建左右button
    if (self.viewControllers.count > 0) {
        //自动隐藏tabbar(底部边栏)
        viewController.hidesBottomBarWhenPushed = YES;

        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithtarget:self Action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        //将自定义按钮给导航栏
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithtarget:self Action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
    }
    //这里要调用父类的方法
    [super pushViewController:viewController animated:YES];
}
- (void) back {
    [self popViewControllerAnimated:YES];
}
- (void) more {
    [self popToRootViewControllerAnimated:YES];
}
@end
