//
//  FilmdetailViewController.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/13.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//
#import "CommonMacro.h"
#import "FilmdetailViewController.h"

#import <UIImageView+AFNetworking.h>

#import "DownLoadDataSource.h"
#define HeaderHeight  200.0

#define FirstoffSet   -0

static NSString * cellID = @"cellID";

@interface FilmdetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)  UIImageView *headerImageView;
@property (nonatomic,strong)DownLoadDataSource * datasource;
@end

@implementation FilmdetailViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIView * view = [[[self.navigationController.navigationBar subviews][0] subviews][0]  subviews][0];
    view.hidden = NO;//还原导航栏
    self.navigationController.navigationBar.shadowImage = nil;

}

-(DownLoadDataSource *)datasource{
    
    if (_datasource == nil) {
        _datasource = [[DownLoadDataSource alloc] init];
        
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, HeaderHeight)];
    UIView * headerView = [[UIView alloc] initWithFrame:self.headerImageView.bounds];
    
    [headerView addSubview:self.headerImageView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    
    [self.headerImageView setImageWithURL:[NSURL URLWithString:_model.poster_url]];

    [self changeAlpha:0];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    [self.datasource loadFilmDetailWithId:self.model.film_id complicate:^(BOOL success, id data) {
        
    }];
    // Do any additional setup after loading the view.
}



-(void)changeAlpha:(float)alpha{
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    //修改导航栏 颜色透明度
    UIView * view = [[[self.navigationController.navigationBar subviews][0] subviews][0]  subviews][0];
    view.hidden = YES;

    UIView * backGroundView = [self.navigationController.navigationBar subviews][0];
    backGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float mm =  FirstoffSet - scrollView.contentOffset.y;
    
    if (mm < 100 && mm  > 0) {
        float scare = mm/100 + 1;
        
        NSLog(@"%f",mm);
        _headerImageView.transform = CGAffineTransformMakeScale(scare, scare);
        
        _headerImageView.center = CGPointMake(_headerImageView.center.x, HeaderHeight/2 - (scare - 1)*HeaderHeight/2);
        

        

    }
    if (mm>100) {
        scrollView.contentOffset = CGPointMake(0, FirstoffSet - mm);
    }
    
    float yy = scrollView.contentOffset.y - FirstoffSet;
    if (yy>0) {
        NSLog(@"====%f",yy);
        
        float alpha = yy/100;
        [self changeAlpha:alpha];

//        [self viewinNaV].backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];

    }
    
    
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
