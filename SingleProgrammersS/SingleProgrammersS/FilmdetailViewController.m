//
//  FilmdetailViewController.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/13.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//
#import "CommonMacro.h"
#import "FilmdetailViewController.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import "UIHeaderView.h"
#import "DownLoadDataSource.h"

#import "ProVideoModel.h"

#import "ProActorsTableViewCell.h"
#import "ProForeshowTableViewCell.h"
static NSString * actorCellID = @"ProActorsTableViewCell";
static NSString * ForeshowID = @"ProForeshowTableViewCell";

#define FirstoffSet   -0
#define defaultHeaderHeight   360

@interface FilmdetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    float HeaderHeight;
}
@property (strong, nonatomic)  UIHeaderView *headerImageView;
@property (nonatomic,strong)DownLoadDataSource * datasource;
@property (nonatomic,strong)DetailInfoModel * detailModel;
@end

@implementation FilmdetailViewController

-(UIHeaderView *)headerImageView{
    if (_headerImageView == nil) {
        _headerImageView = [[[NSBundle mainBundle] loadNibNamed:@"UIHeaderView" owner:self options:nil]lastObject];
        
    }
    _headerImageView.frame = CGRectMake(0, 0, self.view.width, HeaderHeight);
    
    return  _headerImageView;
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
  

   

}

-(DownLoadDataSource *)datasource{
    
    if (_datasource == nil) {
        _datasource = [[DownLoadDataSource alloc] init];
        
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    HeaderHeight = defaultHeaderHeight;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self changeAlpha:0];
    
    self.title = self.model.name;
    
    
    
    [self.tableView registerClass:[ProActorsTableViewCell class] forCellReuseIdentifier:actorCellID];
      [self.tableView registerClass:[ProForeshowTableViewCell class] forCellReuseIdentifier:ForeshowID];
    
    self.tableView.rowHeight = 120;
    
    self.tableView.frame = self.view.bounds;
    
    self.refresh.topEnabled = NO;
    self.refresh.bottomEnabled = NO;
    self.tableView.tableFooterView = [UIView new];
    
    
    [self.view addSubview:self.tableView];
    
    [self showActivity];
    [self.datasource loadFilmDetailWithId:self.model.film_id complicate:^(BOOL success, id data) {
        
        if (success) {
            self.detailModel = data;
            [self refreshView];
        }else{
            [self showToast:[(NSError *)data domain]];
        }
        [self hideActivity];
    }];
    // Do any additional setup after loading the view.
}

/**
 *  更新header
 */
-(void)refreshView{
    
    
    [self.headerImageView refreshGradientLayer];

    self.headerImageView.model = self.detailModel;
    
    UIView * headerView = [[UIView alloc] initWithFrame:self.headerImageView.bounds];
    
    [headerView addSubview:self.headerImageView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView reloadData];
    
}

-(void)changeAlpha:(float)alpha{
    

    //修改导航栏 颜色透明度
    UIView * view = [[[self.navigationController.navigationBar subviews][0] subviews][0]  subviews][0];
    view.hidden = YES;
    
    UIView * shadleImage = [[self.navigationController.navigationBar subviews][0] subviews][1];
    shadleImage.hidden = YES;
    


    UIView * backGroundView = [self.navigationController.navigationBar subviews][0];
    backGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.detailModel) {
        return 2;
    }else{
        return 0;
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ProActorsTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:actorCellID forIndexPath:indexPath];
        cell.models = self.detailModel.creator_info.actors.list;
        
        return cell;

    }else{
       ProForeshowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ForeshowID forIndexPath:indexPath];
        cell.models = self.detailModel.film_photos.list;

        return cell;

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float mm =  FirstoffSet - scrollView.contentOffset.y;
    
    float addTotalHeight = 250;

    float scare = 0;

    if (mm <= 100 && mm  > 0) {
        scare = mm/100 ;
        NSLog(@"%f",mm);
        //放大效果
//        _headerImageView.transform = CGAffineTransformMakeScale(scare, scare);
//        
//        _headerImageView.center = CGPointMake(_headerImageView.center.x, HeaderHeight/2 - (scare - 1)*HeaderHeight/2);

    }
    if (mm>=100) {
        scare = 1;
    }
    //拉伸效果
    _headerImageView.height =scare * addTotalHeight + HeaderHeight;
    _headerImageView.y = -scare*addTotalHeight;
    
    if (mm>=addTotalHeight) {
        
        scrollView.contentOffset = CGPointMake(0, FirstoffSet - addTotalHeight);
    }
    
    

    
    
    
    float yy = scrollView.contentOffset.y - FirstoffSet;
    if (yy>0) {//往下滚动增加
        NSLog(@"====%f",yy);
        
        float alpha = yy/(HeaderHeight + 60);
        if (alpha > 0.8) {
            alpha = 0.8;
        }
        [self changeAlpha:alpha];

    }else{
        
        [self changeAlpha:0];

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
- (IBAction)clickPlay:(id)sender {
    
   
   ProVideoModel * model = [self.detailModel.base_info.videos.list firstObject];
    
    if (model.video_url) {
        [self playerWithUrl:model.video_url];

    }else{
        [self showToast:@"该预告暂时没有"];
    }
    
}

- (IBAction)zhankai:(UIButton *)sender {
    
    if (sender.tag == 0) {//展开
        sender.tag = 1;
        self.headerImageView.labelHeight.constant = [self.detailModel.base_info.desc boundingRectWithSize:CGSizeMake(self.headerImageView.width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.headerImageView.content.font} context:nil].size.height + 20;
       
        
        
    }else {
        //收起
        sender.tag = 0;
        self.headerImageView.labelHeight.constant = defaultHeight;
    }
    
    HeaderHeight = defaultHeaderHeight +self.headerImageView.labelHeight.constant - 60;
    _headerImageView.height = HeaderHeight;
    _headerImageView.y = 0;
    


    [self refreshView];
    
}


-(void)playerWithUrl:(NSString *)urlStr{
    
    MPMoviePlayerViewController * vc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlStr]];
    
    [self presentMoviePlayerViewControllerAnimated:vc];
    
}
@end
