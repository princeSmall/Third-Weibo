//
//  CSStatusFrame.m
//  新浪微博
//
//  Created by 童乐 on 15/11/10.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSStatusFrame.h"
#import "CSStatus.h"
#import "CSUser.h"
#import "NSString+Extension.h"
#import "CSStatusPhotosView.h"

@implementation CSStatusFrame

- (void)setStatus:(CSStatus *)status {
    _status = status;
    CSUser *user = status.user;
    /**头像*/
    CGFloat iconWH = 35;
    CGFloat iconX = CSStatusCellBoardW;
    CGFloat iconY = CSStatusCellBoardW;
    
    self.iconImageViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
     /**昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconImageViewFrame) + CSStatusCellBoardW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:CSStatusCellNameFont ];
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);

    /**会员图标*/
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame) + CSStatusCellBoardW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 15;
        self.VipImageViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /**时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame) + CSStatusCellBoardW;
    CGSize timeSize = [status.created_at sizeWithFont:CSStatusCellTimeFont];
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /**来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame) + CSStatusCellBoardW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:CSStatusCellSourceFont];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    /**内容*/
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconImageViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + 10;
    CGFloat maxW = CSCellW  - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:CSStatusCellContentFont maxW:maxW];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    
    /**配图*/
    CGFloat originalH = 0;
    if (status.pic_urls.count) { //有配图
        CGSize photoSize = [CSStatusPhotosView sizeWithCount:status.pic_urls.count];
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame) + CSStatusCellBoardW;
        self.photoImageViewFrame = CGRectMake(photoX, photoY, photoSize.width,photoSize.height);
        originalH = CGRectGetMaxY(self.photoImageViewFrame) + CSStatusCellBoardW;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelFrame) + CSStatusCellBoardW;
    }
    
    /**原创微博*/
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = CSCellW;
    self.originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    /**被转发微博*/
    CGFloat toolbarY = 0;
    if (status.retweeted_status) {
        CSStatus *retweetStatus = status.retweeted_status;
        CSUser *retweetStatus_user = retweetStatus.user;
        /**转发正文*/
        CGFloat retweetContentX = CSStatusCellBoardW;
        CGFloat retweetContentY = CSStatusCellBoardW;
         NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweetStatus_user.name,retweetStatus.text];
        CGSize retweetContentsize = [retweetContent sizeWithFont:CSStatusCellRetWeetContentFont maxW:maxW];
        self.retweetcontentLabelFrame = CGRectMake(retweetContentX, retweetContentY, retweetContentsize.width, retweetContentsize.height);
        
        /**转发配图*/
        CGFloat retweetviewH = 0;
        if (retweetStatus.pic_urls.count) { //微博有配图
            CGSize retweetPhotoSize = [CSStatusPhotosView sizeWithCount:retweetStatus.pic_urls.count];
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetcontentLabelFrame) +CSStatusCellBoardW;
            self.retweetphotoImageViewFrame = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoSize.width, retweetPhotoSize.height) ;
            
            retweetviewH = CGRectGetMaxY(self.retweetphotoImageViewFrame) + CSStatusCellBoardW;
        } else { //微博没有配图
            retweetviewH = CGRectGetMaxY(self.retweetcontentLabelFrame) + CSStatusCellBoardW;
        }
        
        /**转发整体*/
        CGFloat retweetviewX = 0;
        CGFloat retweetviewY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetviewW = CSCellW;
        self.retweetViewFrame = CGRectMake(retweetviewX, retweetviewY, retweetviewW, retweetviewH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewFrame) ;
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewFrame);
    }

    /**工具条*/
    CGFloat toolbarX = 0;
    CGFloat toolbarW = CSCellW;
    CGFloat toolbarH = 35;
    self.toolBarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    

    
    /**cell的高度*/
    self.cellH = CGRectGetMaxY(self.toolBarFrame) +  CSStatusCellBoardW;


}
@end
