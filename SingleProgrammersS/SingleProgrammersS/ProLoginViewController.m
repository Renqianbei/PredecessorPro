//
//  ProLoginViewController.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/3.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProLoginViewController.h"
#import "ProChatManager.h"
#import "ProWindowManager.h"
@interface ProLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passworld;

@end

@implementation ProLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButton:(id)sender {
    
    [self showActivity];

    [ProChatManager registureWithUsername:self.username.text passworld:self.passworld.text complicate:^(BOOL ret, id result) {
        
        if (ret) {
            [self showToast:@"注册成功"];
            
        }else {
            [self showToast:@"注册失败"];
            
        }
        [self hideActivity];
    }];
    
}

- (IBAction)loginClick:(id)sender {
    
    
    [ProChatManager loginWithUsername:self.username.text passworld:self.passworld.text complicate:^(BOOL ret, id result) {
        
        
        if (ret) {
            [ProWindowManager setMainrootVC];
        }
        
    }];

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
