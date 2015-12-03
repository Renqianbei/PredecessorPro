//
//  ProChater.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ProChater : JSONModel
@property(nonatomic,strong)NSString * username;
@property(nonatomic,strong)NSString * jid;
@property(nonatomic,strong)NSString * password;
@property(nonatomic,strong)NSString * resource;
@property(nonatomic,strong)NSString * token;


@end
