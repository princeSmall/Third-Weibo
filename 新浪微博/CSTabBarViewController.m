
//
//  CSTabBarViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSTabBarViewController.h"
#import "CSHomeViewController.h"
#import "CSMsgCenterViewController.h"
#import "CSProfileViewController.h"
#import "CSDiscoverViewController.h"
#import "CSNavViewController.h"
#import "CSTabBar.h"
#import "CSPlusController.h"
#import "CSComposeViewController.h"
@interface CSTabBarViewController () <CSTabBarDelegate>

@end

@implementation CSTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置子控制器
    CSHomeViewController *home = [[CSHomeViewController alloc] init];
    [self addChild:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    CSMsgCenterViewController *msgCenter = [[CSMsgCenterViewController alloc] init];
    [self addChild:msgCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    CSDiscoverViewController *discover = [[CSDiscoverViewController alloc] init];
    [self addChild:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    CSProfileViewController *profile = [[CSProfileViewController alloc] init];
    [self addChild:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    CSTabBar *tabBar = [[CSTabBar alloc] init];
    tabBar.delegate = self;
    //更换系统的tabbar 通过kvc可以更改只读的属性
    [self setValue:[[CSTabBar alloc] init] forKeyPath:@"tabBar"];
    
}
- (void)viewWillAppear:(BOOL)animated {
 
}
/**
 *  添加子控制器
 *
 *  @param childVc       子控制器
 *  @param title         名称
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void) addChild:(UIViewController *) childVc title:(NSString *) title image:(NSString *) image selectedImage:(NSString *)selectedImage{
    //设置文字的样式和图片
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //选中时颜色
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //未选中颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = CSRGBColor(123, 123, 123);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //下面这行代码执行完后View即已经创建好了，接下来才会设置导航栏，注释掉后View则不会提前创建
//    childVc.view.backgroundColor =  CSRandomColor;
    
    //设置自定义导航栏
    CSNavViewController *nav = [[CSNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
#pragma mark ******tabBar的代理方法******
- (void)tabBarDidClickPlusButton:(CSTabBar *)tabBar {
    CSComposeViewController *controller = [[CSComposeViewController alloc] init];
    
    CSNavViewController *navController = [[CSNavViewController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navController animated:YES completion:nil];
}
@end
