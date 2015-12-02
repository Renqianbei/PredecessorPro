//
//  MessageModel.h
//  CellDIY自定制样式
//
//  Created by 任前辈 on 15/10/28.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
//消息模型

@interface MessageModel : JSONModel

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * headimage;
@property(nonatomic,assign)BOOL isSelf;

@end
