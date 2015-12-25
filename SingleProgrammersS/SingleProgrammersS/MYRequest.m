//
//  DownLoadDataSource.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/10.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "MYRequest.h"
#import "AFNetworking.h"
@interface MYRequest()

//用来做请求
@property(nonatomic,strong)AFHTTPRequestOperationManager * manager;

@end

@implementation MYRequest

-(instancetype)init{
    //重写 初始化方法
    if (self = [super init]) {
        
        //初始化 请求类
        
        _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://10.0.8.8/sns"]];//baseUrl
        
    
        
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
//        id object = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
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

@end
