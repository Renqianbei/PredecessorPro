//
//  ProChatManager.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#define ReceivieMessageNotification  @"ReceivieMessageNotification"

#import <Foundation/Foundation.h>
#import "ProManagerProtocol.h"
#import <EaseMobSDK/EaseMob.h>
#import "ProUserManager.h"

#import "MessageModel.h"
typedef void(^SendComplicate)(BOOL ret ,id result);

@interface ProChatManager : NSObject<ProManagerProtocol,EMChatManagerDelegate>

/**
 *  发送聊天信息
 *
 *  @param text       文本
 *  @param receiver   接受者
 *  @param complicate 发送回调
 */
+(void)sendMessage:(NSString *)text to:(NSString*)receiver complicate:(SendComplicate)complicate;

//获取所有聊天信息
+(NSArray *)loadAllMessageWithChatter:(NSString *)chatter;


/**
 *  注册
 *
 *  @param userName  用户名
 *  @param passworld 密码
 */
+(void)registureWithUsername:(NSString *)userName passworld:(NSString *)passworld complicate:(SendComplicate)complicate;


+(void)loginWithUsername:(NSString *)userName passworld:(NSString *)passworld complicate:(SendComplicate)complicate;

/**
 * 退出登陆  是否取消绑定token号
 */
+(void)logoutcomplicate:(SendComplicate)complicate UnbindDeviceToken:(BOOL)ret;


@end
