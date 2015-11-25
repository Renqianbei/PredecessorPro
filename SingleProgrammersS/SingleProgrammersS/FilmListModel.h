//
//  FilmListModel.h
//  Film_1502
//
//  Created by 任前辈 on 15/11/13.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
//影单
@interface FilmListModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * pagelist_id;
@property(nonatomic,strong)NSNumber * movie_count;
@property(nonatomic,strong)NSNumber * follow_count;

@property(nonatomic,strong)UserModel  * user;

@property(nonatomic,strong)NSMutableArray * films;
@end

//用户
@interface UserModel : NSObject

@property(nonatomic,copy)NSString * avatar_large;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * name;

@end