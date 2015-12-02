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

@end
