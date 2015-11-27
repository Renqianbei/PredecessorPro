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

#import "ProCenterViewcontrolelr.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ProCenterViewcontrolelr * centerVC = [[ProCenterViewcontrolelr alloc] init];
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController * tabVC = [storyBoard instantiateViewControllerWithIdentifier:@"tabBarControllerID"];
    
    ViewController * setVc = [[ViewController alloc] init];
    
    
    
    
    BaseNavigationViewController * naVC = [[BaseNavigationViewController alloc] initWithRootViewController:setVc];

    centerVC.type = Fold;//样式
    
    centerVC.viewcontolelrs = @[tabVC,naVC];
    
    
    
    
     
    
    self.navigationVC = [[BaseNavigationViewController alloc] initWithRootViewController:centerVC];
    
    [self.navigationVC setNavigationBarHidden:YES];
    
    self.window.rootViewController = self.navigationVC;

    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    imageView.image = [UIImage imageNamed:@"11_1.jpg"];

    [self.window insertSubview:imageView atIndex:0];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
