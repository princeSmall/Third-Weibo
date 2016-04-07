//
//  CSStatusFrame.h
//  新浪微博
//
//  Created by 童乐 on 15/11/10.
//  Copyright © 2015年 童乐. All rights reserved.
//  存放cell内部所有控件的frame数据
//  存放cell的高度
//  存放数据模型

#import <Foundation/Foundation.h>

@class CSStatus;
@interface CSStatusFrame : NSObject
/**微博昵称字体*/
#define CSStatusCellNameFont [UIFont systemFontOfSize:12]
/**微博时间字体*/
#define CSStatusCellTimeFont [UIFont systemFontOfSize:12]
/**微博来源字体*/
#define CSStatusCellSourceFont [UIFont systemFontOfSize:12]
/**微博正文字体*/
#define CSStatusCellContentFont [UIFont systemFontOfSize:15]
/**转发微博的正文字体*/
#define CSStatusCellRetWeetContentFont [UIFont systemFontOfSize:13]
/**边距*/
#define CSStatusCellBoardW 10
/**屏幕的宽度*/
#define CSCellW [[UIScreen mainScreen] bounds].size.width
@property (nonatomic, strong) CSStatus *status;
/**原创微博整体*/
@property (nonatomic,assign) CGRect  originalViewFrame;
/**头像*/
@property (nonatomic, assign) CGRect iconImageViewFrame;
/**配图*/
@property (nonatomic, assign) CGRect photoImageViewFrame;
/**会员图标*/
@property (nonatomic, assign) CGRect VipImageViewFrame;
/**昵称*/
@property (nonatomic, assign) CGRect nameLabelFrame;
/**时间*/
@property (nonatomic, assign) CGRect timeLabelFrame;
/**来源*/
@property (nonatomic, assign) CGRect sourceLabelFrame;
/**内容*/
@property (nonatomic, assign) CGRect contentLabelFrame;
/**cell的高度*/
@property (nonatomic, assign) CGFloat cellH;


/**转发微博整体*/
@property (nonatomic,assign) CGRect retweetViewFrame;
/**转发内容*/
@property (nonatomic, assign) CGRect retweetcontentLabelFrame;
/**转发配图*/
@property (nonatomic, assign) CGRect retweetphotoImageViewFrame;


/**toolBar*/
@property (nonatomic,assign) CGRect toolBarFrame;

@end
