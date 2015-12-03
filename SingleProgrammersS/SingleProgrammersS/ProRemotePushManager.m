//
//  ProRemotePushManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/3.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProRemotePushManager.h"
#import "AppDelegate.h"
#import "ProChatDetailViewController.h"
#import "ProCenterViewcontrolelr.h"
#import "ProChater.h"
@implementation ProRemotePushManager

+(AppDelegate *)delegate{
    return  (AppDelegate *)[UIApplication sharedApplication].delegate;
}


+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if (userInfo == nil) {
        return;
    }
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    
    //判断当前显示的是否是 对应消息的聊天页  不是就跳转 是就 不动
    
    UINavigationController * rootNav =  (UINavigationController *)[self delegate].window.rootViewController;
    
    [rootNav popToRootViewControllerAnimated:NO];
    
    
    ProCenterViewcontrolelr * vc = (ProCenterViewcontrolelr *)rootNav.topViewController ;
    
    [vc showCenter:NO animation:NO];
//    
    UITabBarController * tabVC = (UITabBarController *)vc.leftViewcontroller;
    
    [tabVC  setSelectedIndex:1];

    UINavigationController * navc = tabVC.viewControllers[1];
    
    
    if ([navc.topViewController isKindOfClass:[ProChatDetailViewController class]]){
        
        ProChatDetailViewController * chatVC =  (ProChatDetailViewController*)navc.topViewController;
        
        if ([chatVC.chater.username isEqualToString:userInfo[@"f"]]) {
            
            return;
        }
        
        
    }
    
    [navc popToRootViewControllerAnimated:NO];

 

}

@end
