//
//  ProThirdManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//


#import "ProThirdManager.h"
#import "ProChatManager.h"
#define EASEKEY    @"predecessor#singlepro"
#define APNSCertName  @"predecessorAPNDev"

@implementation ProThirdManager

+(void)registerThirdSDKWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions{
    
    
    
    
    /**
     *  下面全是聊天
     */
    [ProChatManager shareInstance];
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:EASEKEY apnsCertName:APNSCertName];
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        //ios8 之前的方法
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
}
@end
