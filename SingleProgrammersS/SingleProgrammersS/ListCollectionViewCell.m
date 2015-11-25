//
//  ListCollectionViewCell.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/13.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "ListCollectionViewCell.h"

#import <UIImageView+AFNetworking.h>
@implementation ListCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

 
-(void)setModel:(FilmModel *)model{
    
    [_imageView setImageWithURL:[NSURL URLWithString:model.poster_url]];
    _label.text = model.name;
    
}
@end
