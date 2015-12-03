//
//  ProChatViewController.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/25.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//
#import <EaseMob.h>
#import "ProUserManager.h"

#import "ProChatViewController.h"
#import "ProChatDetailViewController.h"

static NSString * cellIdentifier = @"cellid";

@interface ProChatViewController ()

@end

@implementation ProChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItmeWith:@"登陆"];
    
    
    self.tableView.rowHeight = 200;
    
   
    
    self.models = [NSMutableArray arrayWithObjects:@"ren",@"liu",nil];
    

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.refresh.topEnabled = NO;
    self.refresh.bottomEnabled = NO;
    
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}


-(void)clickRight:(UIBarButtonItem *)item{
    
    item.enabled = NO;
    if ([item.title isEqualToString:@"登陆"]) {
       
        
        [[EaseMob sharedInstance ].chatManager asyncLoginWithUsername:@"liu" password:@"123" completion:^(NSDictionary *loginInfo, EMError *error) {
            
            if (error == nil) {
               
                item.title = @"退出";

                /**
                 *  登陆成功过后 设置自动登陆
                 */
                [self showToast:@"登陆成功"];
            //保存登陆信息
        [ProUserManager shareInstance].user = [[ProChater alloc] initWithDictionary:loginInfo error:nil];

                self.title =  [ProUserManager shareInstance].user.username;

                
            }
            item.enabled = YES;

            
        } onQueue:nil];
    }else{
        
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            
            if (error == nil) {
                
                item.title = @"登陆";
                /**
                 *  登陆成功过后 设置自动登陆
                 */
                [self showToast:@"退出登陆成功"];
                
                
                NSLog(@"%@",info);
                
            }

            
            item.enabled = YES;

        } onQueue:nil];
        

    }
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.models.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.models[indexPath.row];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ProChatDetailViewController * devc = [[ProChatDetailViewController alloc] init];
    
    ProChater * chater = [[ProChater alloc] init];
    chater.username = self.models[indexPath.row];
   
    devc.chater = chater;
    
    devc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:devc animated:YES];
    
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
