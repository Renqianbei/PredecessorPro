//
//  ProVideoModel.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "JSONModel.h"

@interface ProVideoModel : JSONModel

@property(nonatomic,assign)float duration;
@property(nonatomic,copy)NSString * image_url;
@property(nonatomic,copy)NSString * play_url;//网页地址
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * video_url;

@end
