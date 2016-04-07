
//
//  CSDiscoverViewController.m
//  新浪微博
//
//  Created by 童乐 on 15/10/24.
//  Copyright © 2015年 童乐. All rights reserved.
//

#import "CSDiscoverViewController.h"
#import "CSSearchBar.h"
#import "IWGroupItem.h"
#import "IWArrowItem.h"
#import "IWProfileCell.h"
#import "IWLabelItem.h"
#import "IWSettingViewController.h"

@interface CSDiscoverViewController ()

@end

@implementation CSDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CSSearchBar *searchBar = [CSSearchBar searchBar];
    searchBar.height = 35;
    searchBar.width = 350;
    self.navigationItem.titleView = searchBar;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, self.view.frame.size.width, 130)];
    self.pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(250, 145, self.view.frame.size.width/2, 30)];
    self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"1111"], [UIImage imageNamed:@"2222"],[UIImage imageNamed:@"3333"],nil];
    //把scrollView 和 pageView添加到视图中去
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageController];
    [self setuppage:nil];
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
    [self setUpGroup4];
    
}
-(void)setUpGroup0
{
    //热门微博
    IWArrowItem * hot = [IWArrowItem itemWithTitle:@"" image:nil];
    //热门微博
    IWArrowItem * hot1 = [IWArrowItem itemWithTitle:@"" image:nil];
    
    //热门微博
    IWArrowItem * hot2 = [IWArrowItem itemWithTitle:@"" image:nil];
    
    
    IWGroupItem * group = [[IWGroupItem alloc]init];
    group.items =@[hot,hot1,hot2];
    [self.groups addObject:group];
}
-(void)setUpGroup1
{
    IWLabelItem * label = [IWLabelItem itemWithTitle:@"#视界大赏#" image:[UIImage imageNamed:@"expand"]];
    IWLabelItem * label1 = [IWLabelItem itemWithTitle:@"#天价保姆#" image:[UIImage imageNamed:@"expand"]];
    IWGroupItem * group = [[IWGroupItem alloc]init];
    group.items =@[label,label1];
    [self.groups addObject:group];
    
}
-(void)setUpGroup2

{
    //热门微博
    IWArrowItem * hot_status = [IWArrowItem itemWithTitle:@"热门微博" image:[UIImage imageNamed:@"hot_status"]];
    //找人
    IWArrowItem * find_people = [IWArrowItem itemWithTitle:@"找人" image:[UIImage imageNamed:@"find_people"]];

    
    IWGroupItem * group = [[IWGroupItem alloc]init];
    group.items =@[hot_status,find_people];
    [self.groups addObject:group];
}
-(void)setUpGroup3
{
    //视频
    IWArrowItem * video = [IWArrowItem itemWithTitle:@"视频" image:[UIImage imageNamed:@"video"]];
    //玩游戏
    IWArrowItem * game_center = [IWArrowItem itemWithTitle:@"玩游戏" image:[UIImage imageNamed:@"game_center"]];
    //周边
    IWArrowItem * near = [IWArrowItem itemWithTitle:@"周边" image:[UIImage imageNamed:@"near"]];
    

    
    IWGroupItem * group = [[IWGroupItem alloc]init];
    group.items =@[video,game_center,near];
    [self.groups addObject:group];
}
-(void)setUpGroup4
{
    //音乐
    IWArrowItem * music = [IWArrowItem itemWithTitle:@"音乐" image:[UIImage imageNamed:@"music"]];
    //电影
    IWArrowItem * movie = [IWArrowItem itemWithTitle:@"电影" image:[UIImage imageNamed:@"movie"]];
    
    
    IWGroupItem * group = [[IWGroupItem alloc]init];
    group.items =@[music,movie];
    [self.groups addObject:group];
}
-(void)setuppage:(id)sender
{
    //设置委托
    self.scrollView.delegate = self;
    //设置背景颜色
    self.scrollView.backgroundColor = [UIColor blackColor];
    //设置取消触摸
    self.scrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    self.scrollView.clipsToBounds = YES;
    //设置是否可以缩放
    self.scrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    self.scrollView.pagingEnabled = YES;
    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    self.scrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //清除行距
    //用来记录页数
    NSUInteger pages = 0;
    //用来记录scrollView的x坐标
    int originX = 0;
    for(UIImage *image in self.images)
    {
        //创建一个视图
        UIImageView *pImageView =[[UIImageView alloc]initWithFrame:CGRectZero];
        //设置视图的背景色
        pImageView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        //设置imageView的背景图
        [pImageView setImage:image];
        //给imageView设置区域
        CGRect rect = self.scrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = 0;
        rect.size.width = self.scrollView.frame.size.width;
        rect.size.height = self.scrollView.frame.size.height;
        pImageView.frame = rect;
        //设置图片内容的显示模式(自适应模式)
        pImageView.contentMode = UIViewContentModeScaleAspectFill;
        //pImageView.contentMode = UIViewContentModeScaleToFill;
        
        //把视图添加到当前的滚动视图中
        [self.scrollView addSubview:pImageView];
        //下一张视图的x坐标:offset为:self.scrollView.frame.size.width.
        originX += self.scrollView.frame.size.width;
        //记录scrollView内imageView的个数
        pages++;
    }
    //设置页码控制器的响应方法
    [self.pageController addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    //设置总页数
    self.pageController.numberOfPages = pages;
    //默认当前页为第一页
    self.pageController.currentPage = 0;
    //为页码控制器设置标签
    self.pageController.tag = 110;
    //设置滚动视图的位置
    [self.scrollView setContentSize:CGSizeMake(originX, self.scrollView.bounds.size.height)];
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
    //颜色
    self.pageController.pageIndicatorTintColor = [UIColor greenColor];
    self.pageController.currentPageIndicatorTintColor = [UIColor redColor];
    
    
    
}
- (void)changePage:(id)sender
{
    NSLog(@"指示器的当前索引值为:%li",(long)self.pageController.currentPage);
    //获取当前视图的页码
    CGRect rect = self.scrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = self.pageController.currentPage * self.scrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark-----UIScrollViewDelegate---------
//实现协议UIScrollViewDelegate的方法，必须实现的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前视图的宽度
    CGFloat pageWith = scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    int page = floor((scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    //切换改变页码，小圆点
    self.pageController.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
