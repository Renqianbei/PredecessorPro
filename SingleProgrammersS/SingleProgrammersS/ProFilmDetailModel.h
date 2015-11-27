//
//  ProFilmDetailModel.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "JSONModel.h"

#import "ProActors.h"

#import "ProVideoModel.h"

@protocol ProVideoModel

@end

@protocol ProActors

@end


@protocol FilmPhoto



@end


@interface Videolist : JSONModel

@property(nonatomic,strong)NSArray <ProVideoModel,ConvertOnDemand>* list;//里面是

@property(nonatomic,assign)NSInteger total;//总数

@end



@interface ActorList : JSONModel

@property(nonatomic,strong)NSArray <ProActors,ConvertOnDemand>* list;//里面是

@property(nonatomic,assign)NSInteger total;//总数

@end

@interface Creator_info : JSONModel

@property(nonatomic,strong)ActorList * actors;

@end




@interface Film_photos : JSONModel

@property(nonatomic,strong)NSArray <FilmPhoto,ConvertOnDemand>* list;
@property(nonatomic,assign)NSInteger total;
@end


@interface FilmPhoto : JSONModel
@property(nonatomic,copy)NSString * photo_url;
@property(nonatomic,copy)NSString * photo_url_mid;
@property(nonatomic,copy)NSString * photo_url_small;

@end



@interface ProFilmDetailModel : JSONModel

@property(nonatomic,copy)NSString <Optional>* actors;
@property(nonatomic,copy)NSString <Optional>* country;
@property(nonatomic,copy)NSString <Optional>* desc;

@property(nonatomic,copy)NSString <Optional>* directors;

@property(nonatomic,copy)NSString <Optional>* film_id;
@property(nonatomic,copy)NSString <Optional>* poster_url;

@property(nonatomic,strong)Videolist<Optional>*  videos;


@end



@interface DetailInfoModel : JSONModel

@property(nonatomic,strong)ProFilmDetailModel<Optional> *  base_info;

@property(nonatomic,strong)Creator_info <Optional>*  creator_info;

@property(nonatomic,strong)Film_photos <Optional>*  film_photos;

@end


