//
//  ProWindowManager.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/3.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


/**
 *  整体视图层次类
 */
@interface ProWindowManager : NSObject

+(AppDelegate *)delegate;

//设置主页
+(void)setMainrootVC;
//设置登陆页
+(void)setLogIN;

@end
