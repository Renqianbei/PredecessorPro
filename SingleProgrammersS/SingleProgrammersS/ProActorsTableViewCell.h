//
//  ProActorsTableViewCell.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"
#import "ProActors.h"

@interface ProActorsTableViewCell : UITableViewCell<UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView  * collectionView;
@property(nonatomic,strong)NSArray * models;

@end
