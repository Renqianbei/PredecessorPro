//
//  ListTableViewCell.h
//  Film_1502
//
//  Created by 任前辈 on 15/11/13.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmListModel.h"
@interface ListTableViewCell : UITableViewCell<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *rand;

//可以用collectionView 也可以用scrollview
@property (nonatomic,strong)UICollectionView *collectionView;


@property(nonatomic,strong)FilmListModel * model;


@end
