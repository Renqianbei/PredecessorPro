//
//  ProChatDetailViewController.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProChatDetailViewController.h"
#import "ProChatManager.h"
#import "MessageModel.h"
#import "ChatCell.h"

#define TEXTFieldHEIGHT  50
static NSString * cellIdentifier = @"cellIndetifierone";

@interface ProChatDetailViewController ()<UITextFieldDelegate>

{
    NSMutableArray  * _messages;//消息
    
    UITextField * _textField;//
}
@end

@implementation ProChatDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageModel:) name:ReceivieMessageNotification object:nil];
    
    _messages = [NSMutableArray array];

   
    
    [self addtextField];
    
    //加载所有聊天信息
    [_messages addObjectsFromArray:[ProChatManager loadAllMessageWithChatter:self.chater.username]];
    [self.tableView reloadData];
    
    //滚到最后一行
    [self scrollToBottom];

    // Do any additional setup after loading the view from its nib.
}

-(void)addTableView{
    
    
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - TEXTFieldHEIGHT);
    [self.tableView registerClass:[ChatCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self.view addSubview:self.tableView];
    
    self.refresh.topEnabled = NO;
    self.refresh.bottomEnabled = NO;
}

-(void)addtextField{
    
    
    UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(0, KScreenHeight - TEXTFieldHEIGHT, KScreenWidth, TEXTFieldHEIGHT)];
    field.returnKeyType = UIReturnKeySend;
    
    field.delegate = self;
    
    _textField = field;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    
    
    [self.view addSubview:field];
    
   
    
}


-(void)keyboardWillSHow:(NSNotification  *)notification{
 
    NSDictionary * info = notification.userInfo;
    
    float height = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    float duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        _textField.y = KScreenHeight - TEXTFieldHEIGHT - height;
        self.tableView.height = KScreenHeight - TEXTFieldHEIGHT - height;
    } completion:^(BOOL finished) {
        //滚到最后一行
        [self scrollToBottom];

    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    
    NSDictionary * info = notification.userInfo;
    
//    float height = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    float duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        _textField.y = KScreenHeight - TEXTFieldHEIGHT ;
        self.tableView.height = KScreenHeight - TEXTFieldHEIGHT ;

    }completion:^(BOOL finished) {
        //滚到最后一行
        [self scrollToBottom];
    }];
}

-(void)scrollToBottom{
    if (_messages.count == 0) {
        return;
    }
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageModel * model = _messages[indexPath.row];
    
    return [ChatCell cellHeightWith:model];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _messages.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ChatCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    
    MessageModel * model = _messages[indexPath.row];
    
    [cell refreshCell:model];//刷新cell的内容和子视图的位置
    
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    MessageModel * model = [[MessageModel alloc] init];
    
    model.name = [ProUserManager shareInstance].user.username;
    model.content = textField.text;
    model.isSelf = YES;
    
    [ProChatManager sendMessage:textField.text to:self.chater.username complicate:^(BOOL ret, id result) {
        
        NSLog(@"%@",result);
        if (!ret) {
            [self showToast:@"发送失败"];
            
        }else{
            textField.text = nil;
            [_messages addObject:model];
            
            [self.tableView  insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_messages.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            //滚到最后一行
            [self scrollToBottom];

        }
    }];
    
    
    [textField resignFirstResponder];
    
    return YES;
}// called when 'return' key pressed. return NO to ignore.


/**
 *  接受到了 其它人发送来的消息
 *
 *  @param models 消息数组
 */
-(void)didReceiveMessageModel:(NSNotification *)notification{
    
    NSArray * models = notification.object;
    //需要判断 消息 是否是当前页的消息
    
    NSMutableArray * flitters = [NSMutableArray array];
    
    [models enumerateObjectsUsingBlock:^(MessageModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:self.chater.username]) {
           //判断收到的消息 是否属于当前会话
            [flitters addObject:obj];

        }
    }];
    
    
    NSMutableArray * indextPaths = [NSMutableArray array];
    
    for (NSInteger i = 0; i < flitters.count; i ++) {
        
        NSIndexPath * indextPath = [NSIndexPath indexPathForRow:i+_messages.count inSection:0];
        [indextPaths addObject:indextPath];
    }
    
    [_messages addObjectsFromArray:flitters];
    
    [self.tableView insertRowsAtIndexPaths:indextPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    //滚到最后一行
    [self scrollToBottom];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
