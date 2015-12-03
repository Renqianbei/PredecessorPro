//
//  ProChatManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProChatManager.h"
#import "ProWindowManager.h"
#import "MBProgressHUD.h"
@interface ProChatManager()<UIAlertViewDelegate>
{
    EMConversation * _conversation;
}

@end

@implementation ProChatManager

+(instancetype)shareInstance{
    
    static  id manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
        
    });
    
    return manager;
    
}

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        //注册监听
        
        [[[EaseMob sharedInstance] chatManager] addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    
    return self;
}

+(void)sendMessage:(NSString *)text to:(NSString*)receiver complicate:(SendComplicate)complicate{
    
    //文字消息构造
    EMChatText * textchat = [[EMChatText alloc] initWithText:text];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:textchat];
    
    
    
    EMMessage * message = [[EMMessage alloc] initWithReceiver: receiver bodies:@[body]];
    message.messageType = eMessageTypeChat; // 设置为单聊消息
    
    
    //发送消息
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        //将要发送
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        //已经发送
        if (error == nil) {
            //发送成功
            complicate(YES,message);
        }else {
            complicate(NO,error);
            
        }
        
    } onQueue:nil ];
}

/*!
 @method
 @brief 收到消息时的回调
 @param message      消息对象
 @discussion 当EMConversation对象的enableReceiveMessage属性为YES时, 会触发此回调
 针对有附件的消息, 此时附件还未被下载.
 附件下载过程中的进度回调请参考didFetchingMessageAttachments:progress:,
 下载完所有附件后, 回调didMessageAttachmentsStatusChanged:error:会被触发
 */
- (void)didReceiveMessage:(EMMessage *)message{
    
    //接受消息
    NSLog(@"//接受消息%@",message.to);
    
    MessageModel * model = [ProChatManager modelWithTextMessage:message];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ReceivieMessageNotification object:@[model]];
    
}

/*!
 @method
 @brief 接收到离线非透传消息的回调
 @discussion
 @param offlineMessages 接收到的离线列表
 @result
 */
- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages{
    
    //接受到离线消息
    NSMutableArray * models = [NSMutableArray array];
    
    for (EMMessage * message in offlineMessages) {
        NSLog(@"//接受到离线消息%@",message.to);
        
        MessageModel * model = [ProChatManager modelWithTextMessage:message];
        
        [models addObject:model];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ReceivieMessageNotification object:models];
    
}


-(EMConversation *)conversationWithChatter:(NSString *)Chatter{
    
    if (![_conversation.chatter isEqualToString:Chatter]) {
        _conversation = nil;
    }
    
    if (_conversation == nil) {
        //获取与用户的会话 或者创建
        _conversation =
        [[EaseMob sharedInstance].chatManager conversationForChatter:Chatter conversationType:eConversationTypeChat];
    }
    
    return _conversation;
    
}

+(NSArray *)loadAllMessageWithChatter:(NSString *)chatter{
    
    NSArray * messages =  [[[self shareInstance] conversationWithChatter:chatter] loadAllMessages];
    NSMutableArray * models = [NSMutableArray array];
    
    for (EMMessage * message in messages) {
        
        MessageModel * model = [self modelWithTextMessage:message];
        
        [models addObject:model];
    }
    
    return models;
    
}


+(MessageModel *)modelWithTextMessage:(EMMessage  *)message{
    
    MessageModel * model = [[MessageModel alloc] init];
    
    EMTextMessageBody * body = message.messageBodies[0];
    model.content = body.text;
    model.name = message.from;
    if ([message.from isEqualToString:[ProUserManager shareInstance].user.username]) {
        model.isSelf = YES;
    }
    return model;
    
}

+(void)registureWithUsername:(NSString *)userName passworld:(NSString *)passworld complicate:(SendComplicate)complicate{
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userName password:passworld withCompletion:^(NSString *username, NSString *password, EMError *error) {
        
        if (error == nil ) {
            complicate(YES,nil);
        }else {
            complicate(NO,nil);
            
        }
        
    } onQueue:nil];
}


+(void)loginWithUsername:(NSString *)userName passworld:(NSString *)passworld complicate:(SendComplicate)complicate{
    
    //    自动登录在以下几种情况下会被取消
    //
    //    用户调用了SDK的登出动作;
    //    用户在别的设备上更改了密码, 导致此设备上自动登陆失败;
    //    用户的账号被从服务器端删除;
    //    用户从另一个设备登录，把当前设备上登陆的用户踢出.
    //    所以，在您调用登录方法前，应该先判断是否设置了自动登录，如果设置了，则不需要您再调用
    
    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    

    if (!isAutoLogin) {
        
        [MBProgressHUD showHUDAddedTo:[ProWindowManager delegate].window animated:YES];

        [[EaseMob sharedInstance ].chatManager asyncLoginWithUsername:userName password:passworld completion:^(NSDictionary *loginInfo, EMError *error) {
            
            if (error == nil) {
                complicate(YES,nil);
                

                // 设置自动登录
                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                
                //保存登陆信息
                ProChater * model =  [[ProChater alloc] initWithDictionary:loginInfo error:nil];
                [ProUserManager shareInstance].user = model;
                
            }else{
                complicate(NO,nil);
                
            }
            [MBProgressHUD hideHUDForView:[ProWindowManager delegate].window animated:YES];

            
        } onQueue:nil];
        
    }else {
        
        complicate(YES,nil);
        
    }
    

}

/**
 * 退出登陆
 */
+(void)logoutcomplicate:(SendComplicate)complicate UnbindDeviceToken:(BOOL)ret{
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:ret completion:^(NSDictionary *info, EMError *error) {
        
        if (complicate) {
            
            if (error == nil ) {
                
                complicate(YES,nil);
                
            }else {
                complicate(NO,nil);
                
            }
            
        }
        
        
    } onQueue:nil];
    
}



/*!
 @method
 @brief 用户将要进行自动登录操作的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    
    NSLog(@"%@",loginInfo);
    
    [MBProgressHUD showHUDAddedTo:[ProWindowManager delegate].window animated:YES];
}

/*!
 @method
 @brief 用户自动登录完成后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    NSLog(@"%@",loginInfo);
    
    [MBProgressHUD hideHUDForView:[ProWindowManager delegate].window animated:YES];
    
    //保存登陆信息
    ProChater * model =  [[ProChater alloc] initWithDictionary:loginInfo error:nil];
    [ProUserManager shareInstance].user = model;
    
    [ProWindowManager setMainrootVC];
    
}


/*!
 @method
 @brief 接收到好友请求时的通知
 @discussion
 @param username 发起好友请求的用户username
 @param message  收到好友请求时的say hello消息
 */


- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message{
    
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@,好友请求",username] message:message delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"确定", nil];
    alertView.tag = 100;
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag !=100) {
        return;
    }
    NSString * username = [alertView.title stringByReplacingOccurrencesOfString:@",好友请求" withString:@""];
    
    if (buttonIndex == 0) {
        //拒绝
        
        EMError *error = nil;
        BOOL isSuccess = [[EaseMob sharedInstance].chatManager rejectBuddyRequest:username reason:@"就是不同意" error:&error];
        if (isSuccess && !error) {
            NSLog(@"发送拒绝成功");
        }
        
    }else {
        //同意
        EMError *error = nil;
        BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:username error:&error];
        if (isSuccess && !error) {
            NSLog(@"发送同意成功");
        }
    }
}


/*!
 @method
 @brief 好友请求被接受时的回调
 @discussion
 @param username 之前发出的好友请求被用户username接受了
 */
- (void)didAcceptedByBuddy:(NSString *)username{
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"呵呵" message:[NSString stringWithFormat:@"%@同意了你的好友请求",username] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

/*!
 @method
 @brief 好友请求被拒绝时的回调
 @discussion
 @param username 之前发出的好友请求被用户username拒绝了
 */
- (void)didRejectedByBuddy:(NSString *)username{
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"悲剧" message:[NSString stringWithFormat:@"%@,好友请求被拒绝了",username] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}



@end
