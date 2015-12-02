//
//  AppDelegate.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/23.
//  Copyright (c) 2015年 SingleProgrammers. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "ViewController.h"

#import "ProThirdManager.h"

#import "ProCenterViewcontrolelr.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
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
    self.navigationVC = [[BaseNavigationViewController alloc] initWithRootViewController:centerVC];
    
    
    [self.navigationVC setNavigationBarHidden:YES];//隐藏导航栏
    
    self.window.rootViewController = self.navigationVC;

    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    imageView.image = [UIImage imageNamed:@"11_1.jpg"];

    [self.window insertSubview:imageView atIndex:0];
    
    [self.window makeKeyAndVisible];
    
    
    /**
     *  注册第三方相关
     */
    [ProThirdManager registerThirdSDKWithApplication:application options:launchOptions];
    
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

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];

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

@end
