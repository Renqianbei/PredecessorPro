//
//  ProMainViewController.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/25.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProMainViewController.h"
#import "MYRequest.h"
#import "PREFlipView.h"
#import "UserInfoModel.h"
#import <UIImage+AFNetworking.h>

@interface ProMainViewController ()<FlipDelegate>
{
    NSInteger _page;
}
@property (nonatomic,strong)MYRequest * request;

@end

@implementation ProMainViewController

-(MYRequest *)request{
    
    if (_request == nil) {
        _request = [[MYRequest alloc] init];
    }
    return _request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    
    [self showActivity];
    __weak typeof(self) weakself = self;
    
    [self.request downloadWithUrl:userList parameters:@{@"page":@(_page),@"number":@"10"} complicate:^(BOOL success, id data) {
        
        if (success) {
            //解析
            if ([data[@"users"] isKindOfClass:[NSArray class]]) {
               
                NSArray * models = [UserInfoModel arrayOfModelsFromDictionaries:data[@"users"]];
                
                
                [weakself addFliterViewWithModels:models];
            }
         
            
          
        }
        
        
        [weakself hideActivity];
        
        
    }];
    
}

//添加模型
- (void)addFliterViewWithModels:(NSArray *)models{
   
    
    [self.models addObjectsFromArray:models];
    
    for (int i = 0; i < models.count; i ++) {
        
        PREFlipView * view = [[PREFlipView alloc] initWithFrame:CGRectMake(100, 150, 200, 300)];
       
        [view addSubview:[self viewWithModel:models[i]]];
        
        view.model = models[i];
        
        view.delegate = self;
        
        [self.view insertSubview:view atIndex:0];
    }
}


-(UIView *)viewWithModel:(UserInfoModel *)model{
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    float interval = 10;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(interval,interval, view.width - interval*2, 200)];
    
    [imageView setImageWithURL:[NSURL URLWithString:[@"http://10.0.8.8/sns" stringByAppendingString:model.headimage]]];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(interval, imageView.height + imageView.y, imageView.width, view.height - imageView.height - imageView.y)];
    
    label.text = model.username;
    
    [view addSubview:imageView];
    [view addSubview:label];
    
    return view;
    
    
    
}

-(void)flipToTop:(BOOL)top view:(PREFlipView *)flipView{
    
//    [self.models removeObject:flipView.model];
//    [flipView removeFromSuperview];
    if ([self.models lastObject] == flipView.model) {
        //最后一个模型
        NSLog(@"最后一个");
        //删除获取下一页
        _page ++;
        [self loadData];
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
