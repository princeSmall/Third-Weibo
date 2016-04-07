//
//  CSEmotionListView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/19.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSEmotionListView.h"
#import "CSEmotionPageView.h"
/**每页显示的表情数*/
#define CSEmotionPageSize 20
#define CSScreenW [UIScreen mainScreen].bounds.size.width
@interface CSEmotionListView () <UIScrollViewDelegate>
@property (weak,nonatomic) UIScrollView *scrollView;
@property (weak,nonatomic) UIPageControl *pageControl;
@end
@implementation CSEmotionListView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //1 scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
        //pageController
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
        self.pageControl= pageControl;
        [self addSubview:pageControl];
        //只读属性用kvc解决
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
      
    }
    return self;
}
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger count = (emotions.count + CSEmotionPageSize - 1) / CSEmotionPageSize;
    //设置页数
    self.pageControl.numberOfPages = count;
    
    //创建用来显示每一表情的容器
    CSEmotionPageView *pageView = [[CSEmotionPageView alloc] init];
    for (int i = 0; i < count; i ++ ) {
        pageView.backgroundColor = [UIColor whiteColor];
        
        //设置这一页的表情
        NSRange range;
        range.location = i * CSEmotionPageSize;
        NSUInteger left = emotions.count- range.location;
        if (left >= CSEmotionPageSize) { //这一页足够20个
            range.length = CSEmotionPageSize;
        } else {
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    
    //去除scrolView的横竖滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //pagecontrol
    self.pageControl.width = self.width;
    self.pageControl.height= 30;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    //设置scrollView内部的控件的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i ++ ) {
        CSEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = CSScreenW;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    //设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * CSScreenW, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //页码
    double page = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = (int) (page + 0.5);
}
@end
