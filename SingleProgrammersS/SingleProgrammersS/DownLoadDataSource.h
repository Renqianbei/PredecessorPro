//
//  DownLoadDataSource.h
//  Film_1502
//
//  Created by 任前辈 on 15/11/10.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FIRSTPAGE @"http://ting.weibo.com/movieapp/rank/hot"
#define SECONDPAGE @"http://ting.weibo.com/movieapp/rank/coming"
#define THIRDPAGE @"http://ting.weibo.com/movieapp/pagelist/recommend"




#define FILMLIST  @"http://ting.weibo.com/movieapp/pagelist/recommendmovie" 
//首页热映
//@"http://ting.weibo.com/movieapp/rank/hot"

//预告
//@"http://ting.weibo.com/movieapp/rank/coming"

//某电影详情  必须参数 id  为某电影的 id
//@"http://ting.weibo.com/movieapp/page/base" @{@"id":@""}

//影单
//http://ting.weibo.com/movieapp/pagelist/recommend

//影单.推荐 必须参数  id 为推荐单的 id
//@"http://ting.weibo.com/movieapp/pagelist/recommendmovie" @{@"id":@""}

//影单.热议榜
//@"http://ting.weibo.com/movieapp/pagelist/hotpoll"

//影单.想看榜
//http://ting.weibo.com/movieapp/pagelist/willpoll

//不知道是什么 自己试一试
//@"http://ting.weibo.com/movieapp/Pagelist/square"



//给block起 别名
//类型 void(^)(BOOL success , id data)
//别名是 Complicate

//枚举
typedef NS_ENUM(NSInteger, TABLE_TYPE) {
    
    HOT,//热映
    COMING,//推荐
    LIST,//第三页
    
};

typedef void(^Complicate)(BOOL success , id data);

//起别名
typedef NSString *  MYString;

@interface DownLoadDataSource : NSObject


//存放三种页码
{
    NSInteger _page[3];
}
//请求 对应url  对应参数dic 的 内容

//通过 complicate 回调 返回  请求到的内容

-(void)downloadWithUrl:(MYString)urlStr parameters:(NSDictionary *)dic complicate:(Complicate) complicate;



//下载 对应数据     是下一页还是  刷新
-(void)downloadNext:(BOOL)ret complicate:(Complicate) complicate TYPE:(TABLE_TYPE)type;



//获取影单
-(void)loadFilmListWithId:(NSString *)listID complicate:(Complicate)complicate ;


@end
