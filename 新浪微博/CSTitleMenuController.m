
//
//  CSTitleMenuController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/25.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSTitleMenuController.h"
@interface CSTitleMenuController () <UITableViewDataSource,UITableViewDelegate>
@end
@implementation CSTitleMenuController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if(indexPath.row == 1){
        cell.textLabel.text = @"密友";

    }else if(indexPath.row == 2){
        cell.textLabel.text = @"全部";
        
    }
    return cell;
}
@end
