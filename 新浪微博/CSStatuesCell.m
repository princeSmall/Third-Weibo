
//
//  CSStatuesCell.m
//  新浪微博
//
//  Created by 童乐 on 15/11/10.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSStatuesCell.h"
#import "CSStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "CSUser.h"
#import "CSStatus.h"
#import "CSPhoto.h"
#import "CSStatusToolBar.h"
#import "CSStatusPhotosView.h"
#import "CSIconView.h"
@interface CSStatuesCell ()
/**原创微博整体*/
@property (nonatomic,weak) UIView *originalView;
/**头像*/
@property (nonatomic, weak) CSIconView *iconImageView;
/**配图*/
@property (nonatomic, weak) CSStatusPhotosView *photoImageView;
/**会员图标*/
@property (nonatomic, weak) UIImageView *VipImageView;
/**昵称*/
@property (nonatomic, weak) UILabel  *nameLabel;
/**时间*/
@property (nonatomic, weak) UILabel  *timeLabel;
/**来源*/
@property (nonatomic, weak) UILabel  *sourceLabel;
/**内容*/
@property (nonatomic, weak) UILabel  *contentLabel;

/**转发微博整体*/
@property (nonatomic,weak) UIView *retweetView;
/**转发内容*/
@property (nonatomic, weak) UILabel  *retweetcontentLabel;
/**转发配图*/
@property (nonatomic, weak) CSStatusPhotosView *retweetphotoImageView;

/**工具条*/
@property (nonatomic,strong) CSStatusToolBar *toolBar;
@end
@implementation CSStatuesCell
+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *Id = @"statuses";
    CSStatuesCell *cell = [tableview dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[CSStatuesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    return cell;
}

/**
 *  cell的初始化方法
 *  添加所有可能现实的控件，以及控件的一次性设置
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return 
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //去除cell高亮
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        
        //
        [self setupTooLBar];
    }
    return  self;
}
- (void)setFrame:(CGRect)frame {
    frame.origin.y += 10;
    [super setFrame:frame];
}
- (void)setupTooLBar {
    CSStatusToolBar *toolBar = [[CSStatusToolBar alloc] init];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
//    toolBar.backgroundColor = [UIColor redColor];
}
/**
 *  初始化转发微博
 */
- (void) setupRetweet {
    /**转发微博整体*/
    UIView *retweetView = [[UIView alloc] init];
    self.retweetView = retweetView;
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = CSRGBColor(250, 250, 250);
   
    /**转发配图*/
    CSStatusPhotosView *retweetphotoImageView = [[CSStatusPhotosView alloc] init];
    self.retweetphotoImageView = retweetphotoImageView;
    [self.retweetView addSubview:retweetphotoImageView];
    
    /**内容*/
    UILabel  *retweetcontentLabel = [[UILabel alloc] init];
    retweetcontentLabel.font = CSStatusCellRetWeetContentFont;
    retweetcontentLabel.numberOfLines = 0;
    self.retweetcontentLabel = retweetcontentLabel;
    [self.retweetView addSubview:retweetcontentLabel];
}
/**
 *  初始化原创微博
 */
- (void) setupOriginal {
    //1、原创微博整体
    /**原创微博整体*/
    UIView *originalView = [[UIView alloc] init];
    self.originalView = originalView;
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    
    /**头像*/
    CSIconView *iconImageView = [[CSIconView alloc] init];
    self.iconImageView = iconImageView;
//    self.iconImageView.layer.masksToBounds = YES;
//    self.iconImageView.layer.cornerRadius = 25;
    [self.originalView addSubview:iconImageView];
    
    /**配图*/
    CSStatusPhotosView *photoImageView = [[CSStatusPhotosView alloc] init];
    self.photoImageView = photoImageView;
    [self.originalView addSubview:photoImageView];
    
    /**会员图标*/
    UIImageView *VipImageView = [[UIImageView alloc] init];
    self.VipImageView = VipImageView;
    
    //图片居中显示
    VipImageView.contentMode = UIViewContentModeCenter;
    [self.originalView addSubview:VipImageView];
    
    /**昵称*/
    UILabel  *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = CSStatusCellNameFont;
    [self.originalView addSubview:nameLabel];
    
    /**时间*/
    UILabel  *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = CSStatusCellTimeFont;
    [self.originalView addSubview:timeLabel];
    
    /**来源*/
    UILabel  *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = CSStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    [self.originalView addSubview:sourceLabel];
    
    /**内容*/
    UILabel  *contentLabel = [[UILabel alloc] init];
    contentLabel.font = CSStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    [self.originalView addSubview:contentLabel];

}
- (void)setStatusFrame:(CSStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    CSStatus *status = statusFrame.status;
    CSUser *user = status.user;
    
    /**原创微博整体*/
    self.originalView.frame = statusFrame.originalViewFrame;
    
    /**头像*/
    self.iconImageView.frame = statusFrame.iconImageViewFrame;
    self.iconImageView.user = user;
    
    /**配图*/
    if (status.pic_urls.count) {
        self.photoImageView.frame = statusFrame.photoImageViewFrame;
        self.photoImageView.photos = status.pic_urls;
        self.photoImageView.hidden = NO; //cell 的重用问题所以在这里需要这样操作
    } else {
        self.photoImageView.hidden = YES;
    }
    
    /**会员图标*/
    if (user.isVip) {
        self.VipImageView.hidden = NO;
        self.VipImageView.frame = statusFrame.VipImageViewFrame;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.VipImageView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else {
        self.VipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];

    }
    
    /**昵称*/
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;
    
    /**时间*/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelFrame) + CSStatusCellBoardW;
    CGSize timeSize = [time sizeWithFont:CSStatusCellTimeFont];
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLabel.text = time;
   
    /**来源*/
    NSString *source = status.source;
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelFrame) + CSStatusCellBoardW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [source sizeWithFont:CSStatusCellSourceFont];
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    self.sourceLabel.text = source;
    
    
    /**内容*/
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    self.contentLabel.text = status.text;
    
    /**转发的微博*/
    if (status.retweeted_status) {
        CSStatus *retweetStatus = status.retweeted_status;
        CSUser *retweetStatus_user = retweetStatus.user;
        //转发微博的整体
        self.retweetView.frame = statusFrame.retweetViewFrame;
        
        //转发微博正文
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweetStatus_user.name,retweetStatus.text];
        self.retweetcontentLabel.text = retweetContent;
        self.retweetcontentLabel.frame = statusFrame.retweetcontentLabelFrame;
        
        //转发微博的配图
        if (retweetStatus.pic_urls.count) {
            self.retweetphotoImageView.frame = statusFrame.retweetphotoImageViewFrame;
            self.retweetphotoImageView.photos = retweetStatus.pic_urls;          
            self.retweetphotoImageView.hidden = NO;
        } else {
            self.retweetphotoImageView.hidden =YES;
        }
        self.retweetView.hidden = NO;
    } else {
        self.retweetView.hidden = YES;

    }
    
    /**工具条*/
    self.toolBar.frame = statusFrame.toolBarFrame;
    self.toolBar.status = status;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
