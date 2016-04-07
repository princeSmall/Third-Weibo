//
//  CSStatuesCell.h
//  新浪微博
//
//  Created by 童乐 on 15/11/10.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  CSStatusFrame;
@interface CSStatuesCell : UITableViewCell
+ (instancetype) cellWithTableView:(UITableView *) tableview;
@property (nonatomic, strong) CSStatusFrame  *statusFrame;
@end
