//
//  AppDelegate.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/23.
//  Copyright (c) 2015年 SingleProgrammers. All rights reserved.
//
#import "AppDelegate.h"

#import "ProThirdManager.h"
#import "ProRemotePushManager.h"
#import "ProWindowManager.h"
#import "ProLoginViewController.h"
#import "ProChatManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    [ProWindowManager setLogIN];//设置登陆页
    
    //测试使用    [ProWindowManager setMainrootVC];//设置主页

    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
   
    imageView.image = [UIImage imageNamed:@"11_1.jpg"];

    [self.window insertSubview:imageView atIndex:0];
    
    [self.window makeKeyAndVisible];
    
    
    


    /**
     *  注册第三方相关
     */
    [ProThirdManager registerThirdSDKWithApplication:application options:launchOptions];
    
    //处理推送过来的消息
//    [ProRemotePushManager application:application didReceiveRemoteNotification:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];

    [ProChatManager logoutcomplicate:nil UnbindDeviceToken:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
    [ProChatManager loginWithUsername:[ProUserManager shareInstance].user.username passworld:[ProUserManager shareInstance].user.password complicate:^(BOOL ret, id result) {
        
    }];


}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];

}
/**
 *  当前应用程序  被其它程序打开时
 *
 *  @param application       <#application description#>
 *  @param url               通过哪个url打开的
 *  @param sourceApplication 通过哪个应用打开的 （应用的唯一标识）
 *  @param annotation        不知道
 *
 *  @return 。。。
 */
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    NSLog(@"%@==%@==%@==%@",application,url,sourceApplication,annotation);
    
    return NO;
}



// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
    
    NSLog(@"%@",userInfo);
    if (application.applicationState != UIApplicationStateActive){
        
        //处理推送过来的消息
        [ProRemotePushManager application:application didReceiveRemoteNotification:userInfo];
        
    }
    
    
    
}

@end
