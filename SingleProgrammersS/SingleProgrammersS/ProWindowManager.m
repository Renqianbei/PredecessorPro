//
//  ProWindowManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/3.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProWindowManager.h"
#import "BaseNavigationViewController.h"
#import "ViewController.h"
#import "ProCenterViewcontrolelr.h"
#import "ProLoginViewController.h"
@implementation ProWindowManager

+(AppDelegate *)delegate{
    return  (AppDelegate *)[UIApplication sharedApplication].delegate;
}


+(void)setMainrootVC{
    //容器视图控制器
    ProCenterViewcontrolelr * centerVC = [[ProCenterViewcontrolelr alloc] init];
    
    //主页
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    UITabBarController * tabVC = [storyBoard instantiateViewControllerWithIdentifier:@"tabBarControllerID"];
    
    
    //电影页
    ViewController * setVc = [[ViewController alloc] init];
    
    BaseNavigationViewController * naVC = [[BaseNavigationViewController alloc] initWithRootViewController:setVc];//设置页
    
    
    centerVC.type = Fold;//样式
    
    
    centerVC.viewcontolelrs = @[tabVC,naVC];
    
    
    //为了实现一个功能 最外层添加了 一个导航栏
    self.delegate.navigationVC = [[BaseNavigationViewController alloc] initWithRootViewController:centerVC];
    
    
    [self.delegate.navigationVC setNavigationBarHidden:YES];//隐藏导航栏
    
    self.delegate.window.rootViewController = self.delegate.navigationVC;
    
    
}



+(void)setLogIN{
    
    ProLoginViewController * loginVC = [[ProLoginViewController alloc] init];
    
    
    self.delegate.window.rootViewController = loginVC;
}

@end
