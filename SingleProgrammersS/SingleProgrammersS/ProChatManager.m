//
//  ProChatManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProChatManager.h"

@interface ProChatManager()
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
@end
