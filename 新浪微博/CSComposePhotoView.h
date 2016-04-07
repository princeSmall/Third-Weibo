//
//  CSComposePhotoView.h
//  新浪微博
//
//  Created by 童乐 on 15/11/17.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSComposePhotoView : UIView
- (void) addPhoto:(UIImage *) image;
@property (nonatomic, strong,readonly) NSMutableArray *photos;

@end
