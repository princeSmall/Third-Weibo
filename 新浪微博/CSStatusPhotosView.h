//
//  CSStatusPhotosView.h
//  新浪微博
//
//  Created by 童乐 on 15/11/12.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CSStatusPhotoWH 70
#define CSStatusPhotoMargin 10
@interface CSStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;
+ (CGSize) sizeWithCount:(NSInteger) count;
@end
