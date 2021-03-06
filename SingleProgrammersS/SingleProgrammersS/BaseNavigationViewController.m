//
//  BaseNavigationViewController.m
//  App_1502_LOVE
//
//  Created by 任前辈 on 15/11/17.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//
#import "UIImage+Pro_Image.h"
#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置 导航栏 title 的颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
//    self.navigationBar.barStyle = UIBarStyleBlack
    ;//黑色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.8]] forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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
