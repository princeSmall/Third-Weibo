//
//  CSHomeViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "CSDropDownMenu.h"
#import "CSTitleMenuController.h"
#import "AFNetworking.h"
#import "CSAccountTool.h"
#import "CSAccount.h"
#import "CSTitleButton.h"
#import "UIImageView+WebCache.h"
#import "CSUser.h"
#import "CSStatus.h"
#import "CSLoadMoreFooter.h"
#import "CSStatuesCell.h"
#import "CSStatusFrame.h"
@interface CSHomeViewController () <CSDropDownMenuDelegate>
/**返回的微博字典*/
@property (strong,nonatomic) NSMutableArray *statueFrames;
@end

@implementation CSHomeViewController
- (NSMutableArray *)statueFrames {
    if (!_statueFrames) {
        _statueFrames = [NSMutableArray array];
    }
    return  _statueFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = CSRGBColor(240, 240, 240);
    //去除cell分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //设置导航栏内容
    [self setupNav];
    
    //获得用户信息
    [self setupUserInfo];
    
    //集成下拉刷新控件
    [self setupDownRefresh];
    
    //集成下上拉拉刷新控件
    [self setupUpRefresh];
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
#pragma mark ******设置未读微博数******
/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    //    HWLog(@"setupUnreadCount");
    //    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    CSAccount *account = [CSAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       
        // 设置提醒数字(微博的未读数)
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            //设置app图标的数字
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CSLog(@"请求失败-%@", error);
    }];
}

/**
 *  上拉刷新
 *
 *  @return
 */
- (void) setupUpRefresh {
    CSLoadMoreFooter *footer = [CSLoadMoreFooter initWithLoadMoreFooter];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}
/**
 *  集成刷新控件
 */
- (void) setupDownRefresh {
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(loadNewStatues:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //马上进入刷新状态
    [control beginRefreshing];
    [self loadNewStatues:control];
}
/**
 *    将CSStatus 转为 CSStatusFrame数组
 *
 *  @param statuses <#statuses description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *) statusFramesWithStatuses:(NSArray *) statuses {
    NSMutableArray *newFrames = [NSMutableArray array];
    for (CSStatus  *status in statuses) {
        CSStatusFrame *frames = [[CSStatusFrame alloc] init];
        frames.status = status;
        [newFrames addObject:frames];
    }
    return newFrames;
}
#pragma mark ******刷新最新的数据******
- (void) loadNewStatues:(UIRefreshControl *) control {
    
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    CSAccount *account = [CSAccountTool account];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 取出最前面的微博（最新的微博，ID最大的微博）
    CSStatusFrame *firstStatusF = [self.statueFrames firstObject];
    if (firstStatusF) {
        //若指定此参数则返回Id比since_id 大的微博，
        params[@"since_id"] = firstStatusF.status.idstr;
    }
  
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    //发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
       
        //将微博数组转成模型
//        objectArrayWithKeyValuesArray:responseObject[@"statuses"]
        NSArray *newStatues = [CSStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //将CSStatus 转为 CSStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatues];
        
        //将最新的微博数据加到子总数组的前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statueFrames insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        
    
        //显示最新的微博的数量
        [self showNewStatuesCount:newStatues.count];
        
    }
     failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         CSLog(@"请求失败---%@",error);
         [control endRefreshing];

     }];
    
}
#pragma mark ******加载更多的数据******
/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    CSAccount *account = [CSAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    CSStatusFrame *lastStatusF = [self.statueFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [CSStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将CSStatus 转为 CSStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        // 将更多的微博数据，添加到总数组的最后面
        [self.statueFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CSLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}
#pragma mark ******显示最新的微博数量******
/**
 *  显示最新的微博数量
 *
 *  @param count
 */
- (void) showNewStatuesCount:(NSUInteger) count {
    //刷新成功 清空图标数字
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [[UIScreen mainScreen] bounds].size.width ;
    label.height = 35;
    
    if (count == 0) {
        label.text = @"没有最新的微博数据";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    label.y = 64 - label.height ;
    //将label添加到导航控制器的View中并且盖在导航栏的下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    CGFloat duration = 1.0; //延时
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
//        label.y += label.height;
    } completion:^(BOOL finished) {
        
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
}
- (void) setupNav {
    //将自定义导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithtarget:self Action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    //将自定义导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithtarget:self Action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //设置中间标题按钮
    CSTitleButton *titleButton = [[CSTitleButton alloc] init];
    self.navigationItem.titleView = titleButton;
    //让按钮的大小自适应内容
    [titleButton sizeToFit];
    NSString *name = [CSAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
   
    //监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) setupUserInfo {
 //https://api.weibo.com/2/users/show.json
    //access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 //   uid	false	int64	需要查询的用户ID。
    //请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    CSAccount *account = [CSAccountTool account];
    //拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    //发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
        //设置名称
        CSUser *user = [CSUser mj_objectWithKeyValues:responseObject];
        UIButton *titleButton = (UIButton *) self.navigationItem.titleView;
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        //让按钮的大小自适应内容
        [titleButton sizeToFit];
        //存储昵称到沙盒中
        account.name = user.name;
        [CSAccountTool saveAccount:account];
            }
      failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       CSLog(@"请求失败---%@",error);
    }];

}
/**
 *  标题点击
 */
- (void) titleClick:(UIButton *) titleButton{
    //创建下拉菜单
    CSDropDownMenu *menu = [CSDropDownMenu menu];
    //设置代理
    menu.delegate = self;
    
    CSTitleMenuController *menuVC = [[CSTitleMenuController alloc] init];
    menuVC.view.height = 200;
    menuVC.view.width = 100;
    menu.contenController = menuVC;
    //显示
    [menu showFrom:titleButton];
    
    
}
#pragma mark ******下拉菜单的代理方法******
/**
 *  下拉菜单被销毁时按钮箭头改为向下
 *
 *  @param menu
 */
- (void)dropDownMenuDidDismiss:(CSDropDownMenu *)menu {
    UIButton *titleButton = (UIButton *) self.navigationItem.titleView;
    titleButton.selected = NO;
}
/**
 *  下拉菜单显示时按钮箭头向上
 *
 *  @param menu
 */
- (void)dropDownMenuDidShow:(CSDropDownMenu *)menu {
    UIButton *titleButton = (UIButton *) self.navigationItem.titleView;
    titleButton.selected = YES;
}
#pragma mark ******按钮点击方法******

/**
 *  扫描点击
 */
- (void) pop {
    CSLog(@"pop");
}
/**
 *  添加朋友点击
 */
- (void) friendSearch {
    CSLog(@"friendSerch");
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statueFrames.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //初始化自定义cell
    CSStatuesCell *cell = [CSStatuesCell cellWithTableView:tableView];
   
    //给cell传递模型数据
    cell.statusFrame = self.statueFrames[indexPath.row];

    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    // 如果tableView还没有数据，就直接返回
    if (self.statueFrames.count == 0) return;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        CSLog(@"加载更多的微博数据");
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSStatusFrame *frame = self.statueFrames[indexPath.row];
    return frame.cellH;
}
@end
