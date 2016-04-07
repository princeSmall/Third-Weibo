//
//  CSComposePhotoView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/17.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSComposePhotoView.h"
@interface CSComposePhotoView ()

@end
@implementation CSComposePhotoView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _photos = [NSMutableArray array];
    }
    return self;
}
-(void)addPhoto:(UIImage *)image {
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = image;
    [self addSubview:photoView];
    [_photos addObject:image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置尺寸
    NSUInteger count = self.subviews.count;
    int maxCol = 3;
    CGFloat iamgeWH = 100;
    CGFloat imageMargin = 10;
    for (int i = 0; i < count; i ++ ) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col *(iamgeWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row *(iamgeWH + imageMargin);
        
        photoView.width = iamgeWH;
        photoView.height = iamgeWH;
        
    }
}
@end
