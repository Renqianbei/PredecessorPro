//
//  ProForeshowTableViewCell.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProFilmDetailModel.h"

@class Film_photos;

@interface ProForeshowTableViewCell : UITableViewCell<UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView  * collectionView;

@property(nonatomic,strong)NSArray * models;

@end
