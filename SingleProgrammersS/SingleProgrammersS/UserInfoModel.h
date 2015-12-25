//
//  UserInfoModel.h
//  JSONModelDemo
//
//  Created by 任前辈 on 15/9/22.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"
//继承jsonModel
//credit = 30;
//experience = 20;
//friendnum = 1;
//groupid = 5;
//headimage = "/my/headimage.php?uid=140189";
//lastactivity = 0;
//realname = "";
//uid = 140189;
//username = nimazhale;
//viewnum = 0;
@interface UserInfoModel : JSONModel

@property(nonatomic,assign)NSInteger  credit;
@property(nonatomic,copy)NSString * experience;
@property(nonatomic,copy)NSString * friendnum;
@property(nonatomic,copy)NSString * groupid;
@property(nonatomic,copy)NSString * headimage;
@property(nonatomic,copy)NSString * lastactivity;
@property(nonatomic,copy)NSString * realname;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * username;
@property(nonatomic,copy)NSString * viewnum;



@end
