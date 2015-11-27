//
//  DownLoadDataSource.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/10.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "DownLoadDataSource.h"
#import "AFNetworking.h"

#import "FilmModel.h"
#import "FilmListModel.h"
@interface DownLoadDataSource()

//用来做请求
@property(nonatomic,strong)AFHTTPRequestOperationManager * manager;


@end

@implementation DownLoadDataSource

-(instancetype)init{
    //重写 初始化方法
    if (self = [super init]) {
        
        _page[0] = 1;
        _page[1] = 1;
        _page[2] = 1;

        //初始化 请求类
        
        _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://ting.weibo.com"]];//baseUrl
        
    
        
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置json解析器
 
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置成json解析器
        
        //设置可以接受的contentTypes
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        
        
    }
    
    return self;
}



-(void)downloadWithUrl:(MYString)urlStr parameters:(NSDictionary *)dic complicate:(Complicate) complicate{
    
    
    //发送post请求
    [_manager POST:urlStr parameters:dic  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",operation.response);
        
        //成功之后 通过block 回调
        NSError * error = nil;
        //解析
        if (error) {
            
            if (complicate) {//判断 block变量有没有值
                complicate(NO,error);//
            }
            
        }else {
            
            if (complicate) {
                complicate(YES,responseObject);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //请求失败
        if (complicate) {
            complicate(NO,error);
        }
        NSLog(@"%@",error);
        
    }];
    
    
}


-(void)downloadNext:(BOOL)ret complicate:(Complicate) complicate TYPE:(TABLE_TYPE)type{
    
    
    NSString * urlStr = nil;
   
    switch (type) {
        case HOT:
        {
            urlStr =  FIRSTPAGE;
        }
            break;
        case COMING:
        {
            urlStr = SECONDPAGE;
        }
            break;

        case LIST:
        {
            urlStr = THIRDPAGE;
            
        }
            break;

        default:
            break;
    }
    
    if (ret) {//如果是下一页
        _page[type] ++;
        
    }else{
        _page[type] = 1;
    }
    
    
    
    [self downloadWithUrl:urlStr parameters:@{@"page":@(_page[type])} complicate:^(BOOL success, id data) {
        
        
        if (success == NO) {
            complicate(NO,data);
            
            return ;
        }
        
        //解析
        switch (type) {
            case HOT:
            case COMING:
            {
                NSString * key = @[@"ranklist_hot",@"ranklist_coming"][type];
                
                NSArray * array = data[@"data"][key];
              
        NSMutableArray * models = [NSMutableArray arrayWithCapacity:array.count];
                
                for (NSDictionary * dic in array ) {
                    
                    FilmModel * model = [[FilmModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    
                    [models addObject:model];
                }
                
                complicate(YES,models);

            }
                
                break;
                
            case LIST:
            {
                
                
                NSArray * array = data[@"data"][@"list"];
                
                NSMutableArray * models = [NSMutableArray arrayWithCapacity:array.count];
                
                for (NSDictionary * dic in array ) {
                    
                    FilmListModel * model = [[FilmListModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:dic];
                    
                    
                    model.user = [[UserModel alloc] init];
                    
                    [model.user setValuesForKeysWithDictionary:dic[@"user"]];
                    
                    
                    [models addObject:model];
                }
                
                
                
                complicate(YES,models);
                
            }
                
                break;
            default:
                break;
        }
        
    }];
    
    
    
}

-(void)loadFilmListWithId:(NSString *)listID complicate:(Complicate)complicate {
    
   
    [self  downloadWithUrl:FILMLIST parameters:@{@"id":listID} complicate:^(BOOL success, id data) {
        
//        NSLog(@"%@",data);
       
        if (success) {
            NSArray * array = data[@"data"][@"list"];
            
            NSMutableArray * models = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary * dic in array ) {
                
                FilmModel * model = [[FilmModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [models addObject:model];
            }
            if (complicate) {
                complicate(YES,models);

            }

        }else{
            if (complicate) {
                complicate(NO,nil);
                
            }
 
        }
       
        
    }];
    
}

-(void)loadFilmDetailWithId:(NSString *)filmID complicate:(Complicate)complicate{
    
    [self downloadWithUrl:FILMDetail parameters:@{@"film_id":filmID} complicate:^(BOOL success, id data) {
        
//        NSLog(@"%@",data);
        
        if (success) {
            if ([data[@"status"] integerValue] != 1) {
                
                complicate(NO,data);
                
                return ;
            }
            NSDictionary * dic = data[@"data"];
            DetailInfoModel * model = [[DetailInfoModel alloc] initWithDictionary:dic error:nil];
          
            complicate(YES,model);
        }else{
            complicate(NO,data);
        }
        
    }];
}


@end
