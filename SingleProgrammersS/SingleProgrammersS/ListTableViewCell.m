//
//  ListTableViewCell.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/13.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//
#import "CommonMacro.h"
#import "ListTableViewCell.h"

#import "ListCollectionViewCell.h"
static NSString * CocellId = @"listCell";

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //当从xib重加载 会调用这个函数

    
}
//刷新model
-(void)setModel:(FilmListModel *)model{
    _model = model;
    
    _name.text = model.name;
    
    _rand.text = [model.follow_count stringValue];
    
    
    [self.collectionView reloadData];
    
    
}


//懒加载

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 170);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 35, KScreenWidth-10, 200) collectionViewLayout:layout];
        _collectionView.scrollsToTop = NO;
        _collectionView.dataSource = self;
                
        [_collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CocellId];
        
        [self addSubview:_collectionView];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _model.films.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CocellId forIndexPath:indexPath];
    
    cell.model = _model.films[indexPath.row];
    
    return cell;
    
}





@end
