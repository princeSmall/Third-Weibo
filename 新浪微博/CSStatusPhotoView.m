//
//  CSStatusPhotoView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/14.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSStatusPhotoView.h"
#import "CSPhoto.h"
#import "UIImageView+WebCache.h"
@interface CSStatusPhotoView ()
@property (weak,nonatomic) UIImageView *gifView;
@property (weak,nonatomic) UIImageView *longView;
@end
@implementation CSStatusPhotoView
- (UIImageView *)gifView {
    if (_gifView == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;

    }
    return  _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //拉伸到填充
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出部分减掉
        self.clipsToBounds = YES;
           }
    return self;
}
- (void)setPhoto:(CSPhoto *)photo {
    _photo = photo;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示或者隐藏gif控件
    //判断后缀是否为gif
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
//        self.gifView.hidden = NO;
//    }else {
//        self.gifView.hidden = YES;
//    }
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
