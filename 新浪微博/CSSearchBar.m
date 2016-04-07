//
//  CSSearchBar.m
//  新浪微博
//
//  Created by 童乐 on 15/10/25.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSSearchBar.h"

@implementation CSSearchBar
- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置导航栏搜索框
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        //设置放大镜图片
        UIImageView *seachIcon = [[UIImageView alloc]init];
        seachIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        seachIcon.height = 25;
        seachIcon.width = 25;
        seachIcon.contentMode = UIViewContentModeCenter;
        //设置textfield的左边控件
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = seachIcon;
    }
    return self;
}
+ (instancetype) searchBar {
    return [[self alloc] init];
}
@end
