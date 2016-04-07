//
//  CSMsgCenterViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSMsgCenterViewController.h"
#import "ViewControllerOne.h"
#import "ViewControllerTwo.h"
#import "ViewControllerThree.h"
#import "ViewControllerFour.h"
@interface CSMsgCenterViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation CSMsgCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(compsoeMsg)];
    //禁用按钮
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.imageArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"IMG_0338"],[UIImage imageNamed:@"IMG_0336"],[UIImage imageNamed:@"IMG_0339"],[UIImage imageNamed:@"IMG_0331"],[UIImage imageNamed:@"IMG_0332"],[UIImage imageNamed:@"IMG_0333"],[UIImage imageNamed:@"IMG_0334"],[UIImage imageNamed:@"IMG_0335"],[UIImage imageNamed:@"IMG_0340"], nil];
    self.informationArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"@我的"],[NSString stringWithFormat:@"评论"],[NSString stringWithFormat:@"赞"],[NSString stringWithFormat:@"微博等级"],[NSString stringWithFormat:@"微博雷达"],[NSString stringWithFormat:@"微博小秘书"],[NSString stringWithFormat:@"微博电影"],[NSString stringWithFormat:@"微博粉丝群"],[NSString stringWithFormat:@"群通知"], nil];
    
}
- (void) compsoeMsg{
    CSLog(@"compsoeMsg");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  视图即将显示
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"text--mssage%ld",indexPath.row];
    cell.textLabel.text = [self.informationArray objectAtIndex:indexPath.row];
    //圆角设置
    cell.imageView.layer.cornerRadius = 25;
    cell.imageView.layer.masksToBounds = YES;
   //cell.imageview的frame是不可变的，可以用以下方法修改
    UIImage *icon = [self.imageArray objectAtIndex:indexPath.row];
    CGSize itemSize = CGSizeMake(50, 50);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //cell.imageView.image = [self.array objectAtIndex:indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ViewControllerOne * one = [[ViewControllerOne alloc]init];
    ViewControllerTwo * two = [[ViewControllerTwo alloc]init];
    ViewControllerThree * three = [[ViewControllerThree alloc]init];
    ViewControllerFour * four = [[ViewControllerFour alloc]init];
    if (indexPath.section !=0) {
        return;
    }
    switch (indexPath.row) {
        case 0:
            one.title = @"@我的";
            [self.navigationController pushViewController:one animated:YES];
            break;
        case 1:
            two.title = @"我的评论";
            [self.navigationController pushViewController:two animated:YES];
            break;
        case 2:
            three.title = @"赞过我";
            [self.navigationController pushViewController:three animated:YES];
            break;
        case 3:
            four.title = @"微博集合";
            [self.navigationController pushViewController:four animated:YES];
            break;
    
        default:
            break;
    }
}

@end
