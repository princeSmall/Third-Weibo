//
//  CSIconView.m
//  新浪微博
//
//  Created by 童乐 on 15/11/14.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSIconView.h"
#import "UIImageView+WebCache.h"
#import "CSUser.h"
@interface CSIconView ()
@property (weak,nonatomic) UIImageView *verifiedView;
@end
@implementation CSIconView
- (UIImageView *)verifiedView {
    if (!_verifiedView) {
        UIImageView *verifiedView =[[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return  _verifiedView;
}
-(void)setUser:(CSUser *)user {
    _user = user;
    
    //1、下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //2 设置加V图片
    switch (user.verified_type) {
        case CSUserVerifiedTypeNone: //没有任何认证
            self.verifiedView.hidden = YES;
            break;
            
        case CSUserVerifiedTypePersonal: //个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case CSUserVerifiedTypeEnterprisce:
        case CSUserVerifiedTypeMedia:
        case CSUserVerifiedTypeWebsite: //网站官方
           self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case CSUserVerifiedTypeDaren: //微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            break;
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width *0.6;
    self.verifiedView.y = self.height - self.verifiedView.height *0.6;
}
@end
