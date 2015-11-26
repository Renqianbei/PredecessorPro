//
//  ProActors.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "JSONModel.h"

@interface ProActors : JSONModel
@property(nonatomic,copy)NSString * artist_id;
@property(nonatomic,copy)NSString * job;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * profile_image_url;
@property(nonatomic,copy)NSString <Optional> * verified;
@end
