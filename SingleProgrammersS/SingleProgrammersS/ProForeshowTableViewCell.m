//
//  ProForeshowTableViewCell.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProForeshowTableViewCell.h"
static NSString * cellID = @"cellID";

#import "CommonMacro.h"

@implementation ProForeshowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}




-(void)setModels:(NSArray *)models{
    
    _models = models;
    
    [self.collectionView reloadData];
    
}

//懒加载

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(130, 110);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 20, KScreenWidth-10, 115) collectionViewLayout:layout];
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
    
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 110)];
        imageView.tag = 100;
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell addSubview:imageView];
        
    }
    FilmPhoto * model = _models[indexPath.row];
    
    [imageView setImageWithURL:[NSURL URLWithString:model.photo_url_small]];
    
    
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
