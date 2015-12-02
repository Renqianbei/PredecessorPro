//
//  BaseViewController.h
//  App_1502_LOVE
//
//  Created by 任前辈 on 15/11/17.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"
#import "DJRefresh.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface BaseViewController : UIViewController<DJRefreshDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * models;//存放数据



//下拉刷新控件
@property(nonatomic,strong)DJRefresh * refresh;

@property(nonatomic,strong)MBProgressHUD * mbProgressView;

-(UINavigationController*)rootNav;

-(void)createLeftItemWith:(NSString *)title;

-(void)createRightItmeWith:(NSString*)title;

-(void)createBackItemWithTitle:(NSString *)title;


-(void)showActivity;

-(void)hideActivity;

//展示提示信息
-(void)showToast:(NSString*)text;



-(void)keyboardWillSHow:(NSNotification  *)notification;

-(void)keyboardWillHide:(NSNotification  *)notification;

@end
