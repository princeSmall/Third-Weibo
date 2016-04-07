//
//  CSStatusPhotosView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/12.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSStatusPhotosView.h"
#import "CSPhoto.h"

#import "CSStatusPhotoView.h"
#define CSStatusPhotoMaxCol(count) ((count==4)?2:3)
@implementation CSStatusPhotosView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    //创建足够多的imageView
    while (self.subviews.count < photos.count) {
        CSStatusPhotoView *photos = [[CSStatusPhotoView alloc] init];
        [self addSubview:photos];
    }
    //遍历图片控件 设置图片
    for (int i = 0; i < self.subviews.count; i ++) {
        CSStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photos.count) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            
            photoView.hidden = YES;
        }
    }
   
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //设置尺寸
    int maxCol = CSStatusPhotoMaxCol(self.photos.count);
    for (int i = 0; i < self.photos.count; i ++ ) {
        CSStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col *(CSStatusPhotoWH + CSStatusPhotoMargin);
        int row = i / maxCol;
        photoView.y = row *(CSStatusPhotoWH + CSStatusPhotoMargin);
        photoView.width = CSStatusPhotoWH;
        photoView.height = CSStatusPhotoWH;
       
    }
    
    
}
+ (CGSize) sizeWithCount:(NSInteger) count {
    
    //一行的最大列数
 
    NSInteger maxCols = CSStatusPhotoMaxCol(count);
    //列数
    NSInteger cols = count >= maxCols ? maxCols : count;
    CGFloat photoW = cols * CSStatusPhotoWH + (cols - 1) * CSStatusPhotoMargin;
    //行数
    //    NSInteger rows = 0;
    //    if (count % maxCols == 0) {
    //        rows = count / 3;
    //    } else {
    //        rows = count /3 + 1;
    //    }
    NSInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photoH = rows * CSStatusPhotoWH + (rows - 1) * CSStatusPhotoMargin;
    return  CGSizeMake(photoW, photoH);
    
}
@end
