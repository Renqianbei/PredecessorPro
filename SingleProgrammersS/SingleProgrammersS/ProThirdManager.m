//
//  ProThirdManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//


#import "ProThirdManager.h"

#define EASEKEY    @"predecessor#singlepro"


@implementation ProThirdManager

+(void)registerThirdSDKWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions{
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"predecessor#singlepro" apnsCertName:@"predecessorAPNDev" ];
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
}
@end
