//
//  CSDropDownMenu.m
//  新浪微博
//
//  Created by 童乐 on 15/10/25.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSDropDownMenu.h"
@interface CSDropDownMenu ()
/**
 *  将来用来显示具体内容的容器
 */
@property (weak,nonatomic) UIImageView *containerView;
@end
@implementation CSDropDownMenu
/**
 *  懒加载一般需要强指针
 *
 *  @return
 */
- (UIImageView *)containerView {
    if (!_containerView) {
        //添加下拉菜单
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        //开启用户交互功能  因为imageview是默认不能和用户交互的
        containerView.userInteractionEnabled = YES;
        //dropDownMenuc此时会显示在最上面(也即为蒙板的上面)
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return  _containerView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}
+ (instancetype) menu {
    return [[self alloc] init];
}
/**
 *  显示
 */
- (void) showFrom:(UIView *)from {
    //获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加蒙板到窗口上
    [window addSubview:self];
    
    //设置蒙板的尺寸为窗口的尺寸
    self.frame = window.bounds;
    //蒙板的背景色为透明
    self.backgroundColor=[UIColor clearColor];
    
    //设置容器(下拉菜单)的位置
    
    //默认情况下，子控件的frame是以父控件的左上角为坐标原点
    //可以转换坐标系原点，改变frame的参照点
    //将from的坐标系从from.superView改为从window计算,也即为计算from在window中的位置 
    //[from.superview convertRect:from.frame toView:window];
    //bounds即为自己为坐标原点
    //UIView *v = [[UIView alloc] init];
    //v.frame = CGRectMake(20, 30, 50, 50);
    //v.bounds = {0,0},{50,50}
    //v.frame = {20,30},{50,50}
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.y = CGRectGetMaxY(newFrame);
    self.containerView.centerX = CGRectGetMidX(newFrame);
    
    //通知外界自己被显示了
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }
}
/**
 *  销毁
 */
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.height = 0;
        self.containerView.height = 0;
    }];
    //通知外界自己被销毁了
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}
/**
 *  触摸屏膜
 *
 *  @param touches
 *  @param event
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
- (void)setConten:(UIView *)conten {
    _conten = conten;
    //调整内容的位置
    conten.x = 5;
    conten.y = 13;

    //设置容器的高度
    self.containerView.height = CGRectGetMaxY(conten.frame) + 8;
    self.containerView.width = CGRectGetMaxX(conten.frame) + 5;
    //添加内容到容器中
    [self.containerView addSubview:conten];
}
- (void)setContenController:(UIViewController *)contenController {
    _contenController = contenController;
    //将控制器的View传给content
    self.conten = contenController.view;
}
@end
