//
//  ProOtherViewController.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/25.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProOtherViewController.h"
#import "ProChatManager.h"
#import "ProWindowManager.h"
@interface ProOtherViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;

@end

@implementation ProOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItmeWith:@"退出"];
    
    
    // Do any additional setup after loading the view.
}

-(void)clickRight:(UIBarButtonItem *)item{
    
    [self showActivity];
    [ProChatManager logoutcomplicate:^(BOOL ret, id result) {
        if (ret) {
            [self showToast:@"退出登陆成功"];
            [ProWindowManager setLogIN];
        }
        [self hideActivity];
    } UnbindDeviceToken:YES];
    
}



- (IBAction)addFriendClick:(id)sender {
    
    EMError * error = nil;
    
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:self.username.text message:@"我想加您为好友" error:&error];
   
    if (isSuccess && !error) {
        [self showToast:@"好友申请发送成功"];
    }else{
        [self showToast:@"您已经发送过 或者 发送请求失败"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
