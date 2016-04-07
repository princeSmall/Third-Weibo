//
//  CSNewFeatureController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/31.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSNewFeatureController.h"
#import "CSTabBarViewController.h"
#define imageCount 4
@interface CSNewFeatureController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation CSNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    //设置代理
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //添加图片到scrollView
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int  i = 0; i < imageCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.height = scrollH;
        imageView.width  = scrollW;
        imageView.x = i * scrollW;
        imageView.y = 0;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        //如果是最后一个imageView 设置其内容
        if (i == imageCount - 1) {
            [self setUpLastImageView:imageView];
        }
    }
    //设置其他属性
    scrollView.bounces = NO;//去除弹簧效果
    scrollView.contentSize = CGSizeMake(imageCount * scrollW, 0);
    scrollView.pagingEnabled = YES;//分页
    scrollView.showsHorizontalScrollIndicator = NO;//去除水平滚动条
    
    //添加pageControl 如果没有尺寸 子控件也是可以显示的
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.numberOfPages = imageCount;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.currentPageIndicatorTintColor = CSRGBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = CSRGBColor(189, 189, 189);
    [self.view addSubview:pageControl];
}
/**
 *  设置最后一个imageView
 *
 *  @param imageView
 */
- (void)setUpLastImageView:(UIImageView *) imageView {
    
    //开启imageView的交互功能
    imageView.userInteractionEnabled = YES;
   //1.checkBox
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 100;
    shareBtn.height = 30;
    shareBtn.centerY = imageView.height * 0.68;
    shareBtn.centerX = imageView.width * 0.5;
    [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.77;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}
/**
 *  分享给大家
 *
 *  @param sender
 */
- (void) shareBtnClicked:(UIButton *) sender {
    //状态取反
    sender.selected = !sender.selected;
}
/**
 *  开始微博
 */
- (void) startClick {
    //切换到主页面 这里需要更改window的rootViewController 这样新特性的Controller就会销毁 不会再占用内存
    UIWindow *windown = [UIApplication sharedApplication].keyWindow;
    windown.rootViewController = [[CSTabBarViewController alloc] init];
    
}
#pragma mark *****scrollView 的代理方法******
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

@end
