//
//  ProThirdManager.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <EaseMobSDK/EaseMob.h>
@interface ProThirdManager : NSObject

+(void)registerThirdSDKWithApplication:(UIApplication *)application
                               options:(NSDictionary *)launchOptions;

@end
