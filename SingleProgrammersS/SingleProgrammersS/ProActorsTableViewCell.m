//
//  ProActorsTableViewCell.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProActorsTableViewCell.h"


static NSString * cellID = @"cellID";

@implementation ProActorsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModels:(NSArray *)models{
    
    _models = models;
    
    [self.collectionView reloadData];
    
}

//懒加载

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 20, KScreenWidth-10, 100) collectionViewLayout:layout];
        _collectionView.scrollsToTop = NO;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        [self addSubview:_collectionView];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _models.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    UIImageView * imageView = [cell viewWithTag:100];
    UILabel * label = [cell viewWithTag:101];
    
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.layer.cornerRadius = 35;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 100;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 70, 20)];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 101;
        [cell addSubview:imageView];
        [cell addSubview:label];
    }
    ProActors * model = _models[indexPath.row];

    
    [imageView setImageWithURL:[NSURL URLWithString:model.profile_image_url]];
    
    
    label.text = model.name;
    
    
    return cell;
    
}

@end
