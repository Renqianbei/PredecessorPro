//
//  BaseViewController.m
//  App_1502_LOVE
//
//  Created by 任前辈 on 15/11/17.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

-(UINavigationController*)rootNav{
    
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).navigationVC;
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets
    = YES;
    // Do any additional setup after loading the view.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillSHow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)keyboardWillSHow:(NSNotification  *)notification{
    
}

-(void)keyboardWillHide:(NSNotification  *)notification{
    
}


-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - TabHeight) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //刷新控件
        self.refresh = [[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
        
        self.refresh.topEnabled = YES;
        self.refresh.bottomEnabled = YES;
        
        
    }
    
    return _tableView;
    
}

-(NSMutableArray *)models{
    
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    
    return _models;
}


-(void)createLeftItemWith:(NSString *)title {
    
   
    
    UIBarButtonItem * item = [self itemWithSelector:@selector(clickLeft:) title:title];
    //左边按钮
    self.navigationItem.leftBarButtonItem = item;
    
}

-(void)createRightItmeWith:(NSString *)title{
    
    UIBarButtonItem * item = [self itemWithSelector:@selector(clickRight:) title:title];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = item;
    
}

//返回按钮
-(void)createBackItemWithTitle:(NSString *)title{
    
    UIBarButtonItem * item = [self itemWithSelector:@selector(clickBack:) title:title];
    
    //设置返回按钮
    self.navigationItem.backBarButtonItem = item;
    
    
}


-(void)clickBack:(UIBarButtonItem *)item{
    
}

-(void)clickRight:(UIBarButtonItem *)item{
    
}

-(void)clickLeft:(UIBarButtonItem *)item{
    
}



//创建item
-(UIBarButtonItem * )itemWithSelector:(SEL)selector title:(NSString*)title{
    
   
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(0, 0, 60, 35);
//
//    
//    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
//    
//    [button setTitle:title forState:UIControlStateNormal];
//    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(clickRight:)];
    
    
    return item;
    
    
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}

//展示菊花
-(void)showActivity{
    
    self.mbProgressView.labelText = nil;
    self.mbProgressView.mode = MBProgressHUDModeIndeterminate;
    [self.view bringSubviewToFront:self.mbProgressView];
    [self.mbProgressView show:YES];
}

-(void)hideActivity{
    
    [self.mbProgressView hide:YES];
}

//展示 提示信息
-(void)showToast:(NSString*)text{
    
    self.mbProgressView.labelText = text;
    self.mbProgressView.mode = MBProgressHUDModeText;
    [self.view bringSubviewToFront:self.mbProgressView];

    [self.mbProgressView show:YES];
    [self.mbProgressView hide:YES afterDelay:1];
    
}



-(MBProgressHUD *)mbProgressView{
    
    if (_mbProgressView == nil) {
        _mbProgressView = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mbProgressView];
    }
    
    return _mbProgressView;
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
