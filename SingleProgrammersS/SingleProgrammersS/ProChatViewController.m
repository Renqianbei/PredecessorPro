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
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@的好友列表",[ProUserManager shareInstance].user.username];
    
    self.tableView.rowHeight = 200;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.refresh.topEnabled = YES;
    self.refresh.bottomEnabled = NO;
    
    [self.view addSubview:self.tableView];

    [self loadDataComplicate:nil];
    // Do any additional setup after loading the view.
}

-(void)loadDataComplicate:(void(^)())complicate{
   
    [self showActivity];
    //获取好友列表
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            
            self.models = [NSMutableArray arrayWithArray:buddyList];
            [self.tableView reloadData];
        }
        [self hideActivity];
        if (complicate) {
            complicate();
        }
    } onQueue:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.models.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    EMBuddy * friend = self.models[indexPath.row];
    
    cell.textLabel.text = friend.username;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ProChatDetailViewController * devc = [[ProChatDetailViewController alloc] init];
    
    ProChater * chater = [[ProChater alloc] init];
    EMBuddy * friend = self.models[indexPath.row];

    chater.username = friend.username;
   
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

-(void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
        [self loadDataComplicate:^{
            [refresh finishRefreshing];
        }];
}
@end
