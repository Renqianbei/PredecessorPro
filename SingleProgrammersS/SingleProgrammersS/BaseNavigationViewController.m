//
//  BaseNavigationViewController.m
//  App_1502_LOVE
//
//  Created by 任前辈 on 15/11/17.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    
    //设置 导航栏 title 的颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:22],NSForegroundColorAttributeName : [UIColor grayColor]}];
    
    UIImage * image = [UIImage imageNamed:@"navigationbar"];
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    
    // Do any additional setup after loading the view.
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
