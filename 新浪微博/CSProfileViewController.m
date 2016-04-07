//
//  CSProfileViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/11/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSProfileViewController.h"
#import "IWGroupItem.h"
#import "IWArrowItem.h"
#import "IWProfileCell.h"
#import "IWSettingViewController.h"
@interface CSProfileViewController ()

@end

@implementation CSProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    
}
- (void)setUpGroup0
{
    // 新的好友
    IWArrowItem *friend = [IWArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[friend];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 我的相册
    IWArrowItem *album = [IWArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(12)";
    
    // 我的收藏
    IWArrowItem *collect = [IWArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    
    // 赞
    IWArrowItem *like = [IWArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";
    
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[album,collect,like];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 微博支付
    IWArrowItem *pay = [IWArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    // 个性化
    IWArrowItem *vip = [IWArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源、皮肤、封面图";
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[pay,vip];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 我的二维码
    IWArrowItem *card = [IWArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    // 草稿箱
    IWArrowItem *draft = [IWArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[card,draft];
    [self.groups addObject:group];
}

- (void)setUpNav
{
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = setting;
    
}

- (void)setting
{
    IWSettingViewController *settingVc = [[IWSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWProfileCell *cell = [IWProfileCell cellWithTableView:tableView];
    
    // 获取模型
    IWGroupItem *groupItem = self.groups[indexPath.section];
    IWSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    [cell setIndexPath:indexPath rowCount:(int)groupItem.items.count];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}
@end
