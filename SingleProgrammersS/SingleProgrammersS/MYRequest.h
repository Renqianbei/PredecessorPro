//
//  DownLoadDataSource.h
//  Film_1502
//
//  Created by 任前辈 on 15/12/25.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define userList @"my/user_list.php"


//给block起 别名
//类型 void(^)(BOOL success , id data)
//别名是 Complicate

typedef void(^Complicate)(BOOL success , id data);

//起别名
typedef NSString *  MYString;

@interface MYRequest : NSObject

//请求 对应url  对应参数dic 的 内容

//通过 complicate 回调 返回  请求到的内容
-(void)downloadWithUrl:(MYString)urlStr parameters:(NSDictionary *)dic complicate:(Complicate) complicate;



@end
