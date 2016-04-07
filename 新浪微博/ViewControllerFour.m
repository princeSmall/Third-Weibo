//
//  ViewControllerFour.m
//  新浪微博
//
//  Created by sansi on 16/3/28.
//  Copyright © 2016年 石冬冬. All rights reserved.
//

#import "ViewControllerFour.h"

@interface ViewControllerFour ()

@end

@implementation ViewControllerFour
@synthesize informationLabel = _informationLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.imageView.frame=CGRectMake(10, 10, 50, 50);
    self.imageView.layer.cornerRadius=25;
    self.imageView.layer.masksToBounds =YES;
    //self.informationLabel.text = @"information";
    
    self.informationLabel.text=@"感谢您关注@微博等级，等级是微博用户成长和活跃的见证，每天完成简单的任务，等级会随之增长，等级越高，破解的特权越多，获得的专属福利越丰厚哦，预知你的等级和专属特权请戳>网页链接";
//    //设置字体颜色为白色
      self.informationLabel.textColor = [UIColor blackColor];
//    //文字居中显示
      self.informationLabel.textAlignment = UITextAlignmentCenter;
//    //自动折行设置
    self.informationLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.informationLabel.numberOfLines = 0;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
