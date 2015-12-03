//
//  ProRemotePushManager.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/3.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  推送相关处理类
 */
@interface ProRemotePushManager : NSObject

+(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo ;

@end
