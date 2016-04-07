//
//  CSProfileCell.m
//  新浪微博
//
//  Created by 童乐 on 15/11/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSProfileCell.h"

@implementation CSProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

@end
