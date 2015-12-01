//
//  ViewController.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/10.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#define radioHeight 300

#import "ViewController.h"
#import "FilmdetailViewController.h"

#import "DownLoadDataSource.h"

#import "FilmModel.h"
#import "DJRefresh.h"

#import "FilmCell.h"
#import "ListTableViewCell.h"
#import "CommonMacro.h"
//cell复用标识

#define tableTag  100
#define scrollViewTag 200

#define  TableCount 3

static NSString * cellIndentifier = @"Mycell";

static NSString * cellList = @"cellList";


#define tableViewHeight     (KScreenHeight)


typedef enum viewType{
    Top,
    Center,
    Bottom,
}ViewType;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,UICollectionViewDelegate>

{
    
    
    NSMutableArray * _dataSource;//用来显示的数据
    
    
    
    
    
}
@property(nonatomic,strong)DownLoadDataSource * download;
@property(nonatomic,strong)UIPanGestureRecognizer * panGesture;
@property(nonatomic,strong)NSMutableArray * refreshViews;//实现刷新
@property(nonatomic,strong)UIView * mainView;

@property(nonatomic,assign)ViewType showType;

@end

@implementation ViewController

/*
 懒加载
 */

-(DownLoadDataSource *)download{
    
    if (_download == nil) {
        _download = [[DownLoadDataSource alloc] init];
    }
    return _download;
    
}

//加载数据 重新加载数据
-(void)loadDataComplicate:(void(^)())complicate type:(TABLE_TYPE)type next:(BOOL)ret{
  
    if (ret == NO) {
        [self showActivity];
    }
    [self.download  downloadNext:ret complicate:^(BOOL success, id data) {
        
        if (success) {
            if (ret) {
                
                [_dataSource[type] addObjectsFromArray:data];
                
            }else{
                [_dataSource[type] removeAllObjects];
                [_dataSource[type] addObjectsFromArray:data];

            }
            
            [[self tableViewType:type] reloadData];
        }else{
            NSLog(@"%@",data);
            [self showToast:[(NSError *)data domain]];
        }
        
        if (complicate) {
            complicate();
        }
        
        [self hideActivity];

        
    } TYPE:type];
    
}


-(UIPanGestureRecognizer *)panGesture{
    
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMYView:)];
        
    }
    return _panGesture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _refreshViews = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    [self createMainView];
    
    //加载中间页的数据
    [self loadDataComplicate:nil type:COMING next:NO];


   
    /**
     给右边添加一个 view可以实现立体滚动
     
     */
    UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(self.view.width-20, 0, 20, self.view.height)];
    blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];

    [self.view addSubview:blackView];
    
    [blackView addGestureRecognizer:self.panGesture];

    //
    // Do any additional setup after loading the view, typically from a nib.
}





-(void)createMainView{
    
    self.mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainView];
    
    [self addTableView];
    

}


- (void)addTableView{
    
    _dataSource = [NSMutableArray array];//初始数据源
    
    
    for (int i =0; i < TableCount; i ++) {
        
        NSMutableArray * mutArray = [[NSMutableArray alloc] init];
        
        [_dataSource addObject:mutArray];
        
        UITableView *  _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, tableViewHeight) style:UITableViewStylePlain];
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(TopOffSet, 0, 0, 0);
        
        _tableView.rowHeight = 200;
        
        _tableView.tableFooterView = [UIView new];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = i + tableTag ;
        
        //注册cell
        
        switch (i) {
            case HOT:
            case COMING:
            {
                [_tableView registerNib:[UINib nibWithNibName:@"FilmCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
                
            }
                break;
            case LIST:
                [_tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:cellList];
                
                break;
            default:
                break;
        }
        
        
        DJRefresh * refresh = [[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
        refresh.topEnabled = YES;
        refresh.bottomEnabled = YES;
        
        [_refreshViews addObject:refresh];//存放下拉控件 避免被释放
        
        _tableView.tag = i + tableTag ;

        [self.mainView addSubview:_tableView];
        

    }
    
    
    self.showType = Center;//初始显示中间
    
    [self forbidAllTableViewscrollToTop];
    
    [self tableViewType:COMING].scrollsToTop = YES;
    self.title = @"推荐";

    [self.mainView bringSubviewToFront:[self tableViewType:COMING]];//让中间显示到最上层
    
   

}


/**
 *  禁用所有 scrollview 点击顶部回到顶部
 */
-(void)forbidAllTableViewscrollToTop{
    
    for (int i = 0; i < 3; i ++) {
       UITableView * tableView = [self tableViewType:i];
        tableView.scrollsToTop = NO;
    }
}


//通过type值 找tabelView
-(UITableView *)tableViewType:(TABLE_TYPE)type{
    
   return  (UITableView *)[self.mainView viewWithTag:type+tableTag];
    
    
}

#pragma mark tabelView delegate

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == tableTag + LIST) {
        return 230;
    }
    return FirstCellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    
    return [_dataSource[tableView.tag - tableTag] count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TABLE_TYPE type = tableView.tag - tableTag;//对应tableView
    
    switch (type ) {
        case HOT:
        case COMING:
        {
            FilmCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
            
            //刷新cell的内容
            FilmModel * model =_dataSource[type][indexPath.row];
          
            [cell refreshWithModel:model];
            
            return cell;
        }
            break;
        
        case LIST:
            //列表
        {
            ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellList forIndexPath:indexPath];
            
            //刷新cell的内容
            
            FilmListModel * model =_dataSource[type][indexPath.row];
            
            cell.collectionView.delegate = self;//设置cell的代理
            cell.model = model;//更新cell
            
          
            //cell 需要请求数据 cell中显示的电影需要网络请求
            
            if (model.films.count == 0) {
                
                [self.download loadFilmListWithId:cell.model.pagelist_id complicate:^(BOOL success, id data) {
                    
                    if (success) {
                    
                        if (cell.model == model) {//请求到数据刷新cell
                            
                            cell.model.films = [NSMutableArray arrayWithArray:data];
                            [cell.collectionView reloadData];
                            
                        }
                    }
                    
                }];

            }
            
            return cell;
        }
            
        default:
            break;
    }
    
    
    
    return nil;
    
}

#pragma mark  刷新 的代理方法

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    
    void (^complicate)();//声明
    //赋值
    complicate = ^{
        //收回下拉刷新
        [refresh finishRefreshing];
    };
    
    if (direction == DJRefreshDirectionTop) {
       

        //刷新数据
        [self loadDataComplicate:complicate type:refresh.scrollView.tag - tableTag next:NO];
        
        
    }else{
        //请求下一页的数据
        [self loadDataComplicate:complicate type:refresh.scrollView.tag - tableTag next:YES];

        
    }
    
}


//滚动 如果没有数据 请求数据

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TABLE_TYPE type = tableView.tag - tableTag;
    
    
    
    switch (type) {
        case HOT:
        case COMING:
        {
           FilmModel * model = _dataSource[type][indexPath.row];
            [self jumpToDetailVCWithModel:model];
        }
            break;
        case LIST:
        default:
            break;
    }
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListTableViewCell * cell = (ListTableViewCell *)[collectionView superview];
    
    FilmModel * model = cell.model.films[indexPath.item];
    
    [self jumpToDetailVCWithModel:model];
    
}


-(void)jumpToDetailVCWithModel:(FilmModel *)model{
    
    
    FilmdetailViewController * dvc = [[FilmdetailViewController alloc] init];
    dvc.model = model;
    
    [self.rootNav pushViewController:dvc animated:YES];
    
}







#pragma mark 旋转相关 的计算

-(void)refreshTableViewAngle:(float)angle{
    
    NSLog(@"角度%f",angle);
    
   
    for (int i = 0; i < 3; i ++) {
    
       UIView * view = [self tableViewType:i];
        
        [self setRotationAngle:angle + M_PI_2*i - M_PI_2   view:view];
        
        
    }
}


- (void)setRotationAngle:(float)angle view:(UIView *)view{
    
    CATransform3D   move = CATransform3DMakeTranslation(0,0, tableViewHeight/2.0);
    CATransform3D   back = CATransform3DMakeTranslation(0, 0, -tableViewHeight/2.0);

    
    CATransform3D rotation = CATransform3DConcat(CATransform3DConcat(move,CATransform3DMakeRotation( angle, 1, 0, 0)), back);
    
    view.layer.transform = ProTransFormWithCenterOffset(CGPointZero, rotation);
}


CATransform3D  ProTransFormWithCenterOffset(CGPoint center , CATransform3D transform){
    
    CATransform3D scare = CATransform3DIdentity;
    scare.m34 = -1/1000.0;
    
    CATransform3D   move = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D   back = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    
    scare = CATransform3DConcat(CATransform3DConcat(move, scare), back);
    
    return CATransform3DConcat( transform,scare);
    
}


- (void)panMYView:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan locationInView:self.view];
    
    
    static CGPoint startPoint ;
    
    
    [self hiddenTop:NO Bottom:NO];

    switch (pan.state ) {
        case UIGestureRecognizerStateBegan:
        {
            startPoint = point;
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            

            
            float offset = point.y - startPoint.y;
            
            switch (self.showType) {
                case Top:
                {
                    if (offset>=0) {
                        return;
                    }
                    
                    offset += radioHeight;
                }
                    
                    break;
                case Center:
                {
                    
                }
                    break;
                case Bottom:
                {
                    if (offset<=0) {
                        return;
                    }
                    offset -= radioHeight;

                }
                    break;
                default:
                    break;
            }
            
            
            [self rotationWithOffSet:offset];

            
            
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
            float offset = point.y - startPoint.y;

            NSLog(@"---%f",offset);

            //趋势
            CGPoint velocityPoint = [pan velocityInView:self.view];
            
            double endangle = 0;
            
            [self hiddenTop:NO Bottom:NO];

            switch (self.showType) {
                case Top:
                {
                    if (offset>=0) {
                        return;
                    }
                    offset += radioHeight;

                    
                    //从顶部往中间或者 底部翻转
                    if (offset <0) {
          
                        endangle = M_PI_2;//显示底部
                        [self hiddenTop:YES Bottom:NO];
                        
                        break;
                    }

                    if (velocityPoint.y<0) {
                        
                            endangle = 0;
                            [self hiddenTop:NO Bottom:YES];
                        //
                        
                    }else {
                        endangle = -M_PI_2;  //显示top

                    }

                }
                    break;
                case Center:
                {

                    if (offset > 0) {//下翻
                        if (velocityPoint.y>0) {//趋势向下
                            endangle = -M_PI_2 ; //显示top
                        }else {
                            endangle = 0;
                        }
                        
                        [self hiddenTop:NO Bottom:YES];

                    }else {//上翻
                       
                        if (velocityPoint.y<0) {//趋势向上
                            endangle = M_PI_2;//显示bottom

                        }else {
                            endangle = 0;
                        }
                        [self hiddenTop:YES Bottom:NO];

                    }
                    
                }
                    break;
                case Bottom:
                {
                    if (offset<=0) {//底部不能继续往底部翻了
                        return;
                    }
                    
                  
                    offset -= radioHeight;
                   
//                     从底部往上翻 可能到中间 可能到顶部

                    if (offset>0) {
                        endangle = -M_PI_2;//显示顶部
                        [self hiddenTop:NO Bottom:YES];

                        break;
                    }
                    
                    //向下翻
                    if (velocityPoint.y>0) {//趋势向下
                        
                            endangle = 0;//显示中间
                            [self hiddenTop:YES Bottom:NO];

                        
                    }else {
                        
                        endangle = M_PI_2;//显示bottom
                        
                    }


                }
                    break;
                default:
                    break;
            }
        
            [self rotationWithOffSet:offset];

            
            
           
            [UIView animateWithDuration:0.5 animations:^{
                
                [self refreshTableViewAngle:endangle];//设置偏移量

            }completion:^(BOOL finished) {
                if (endangle == 0) {
                    self.showType = Center;
                    
                    [self showViewWithType:COMING];
                    
                }else if (endangle == -M_PI_2){
                    self.showType = Top;
                    [self showViewWithType:LIST];

                }else{
                    self.showType = Bottom;
                    [self showViewWithType:HOT];

                }
                
            }];
            
        }
            break;
            
            
        default:
            break;
    }
    
    
}

-(void)showViewWithType:(TABLE_TYPE)type{
    
    switch (type) {
        
        case HOT:
        {
            self.title = @"热门";
            
        }
            
            break;
        case COMING:
        {
            self.title = @"推荐";
            
        }
            break;
        case LIST:
        {
            self.title = @"影单";
            
        }
            break;
            
        default:
            break;
    }
    
    if ([_dataSource[type] count] == 0) {
        [self loadDataComplicate:nil type:type next:NO];
    }
    
    [self forbidAllTableViewscrollToTop];
  
    [self tableViewType:type].layer.transform = CATransform3DIdentity;
    
    [self tableViewType:type].scrollsToTop = YES;
    
    
    [self.mainView insertSubview:[self tableViewType:type] belowSubview:self.panGesture.view];
}




-(void)hiddenTop:(BOOL)top  Bottom:(BOOL)bottom{
    
    //解决翻转的时候 各种视图乱跳的问题
    [self tableViewType:0].hidden = bottom;
    [self tableViewType:2].hidden = top
    ;
}



-(void)rotationWithOffSet:(float)offSet {
    
    float radio = -offSet/radioHeight;
    
    float angle = radio*M_PI_2 ;
    
    if (angle>M_PI_2) {
        angle = M_PI_2;
        
    }else if(angle < -M_PI_2){
        angle = -M_PI_2;
    }
    
    [self refreshTableViewAngle:angle];//设置偏移量
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
