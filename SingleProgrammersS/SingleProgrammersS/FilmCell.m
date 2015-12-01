//
//  FilmCell.m
//  Film_1502
//
//  Created by 任前辈 on 15/11/10.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "FilmCell.h"
#import "CommonMacro.h"
#import <UIImageView+AFNetworking.h>
@implementation FilmCell


-(void)refreshWithModel:(FilmModel *)model{
    
    //更新内容
    
    self.scoreLabel.text = model.score;
    self.name.text = model.name;
    
    [self.filmImageView setImageWithURL:[NSURL URLWithString:model.poster_url]];

    
}


- (void)awakeFromNib {
    // Initialization code
    
    CAGradientLayer * gradientLayer= [[CAGradientLayer alloc] init];
    
    gradientLayer.colors = @[(id)[[UIColor clearColor] CGColor],(id)[[UIColor blackColor] CGColor]];
    
    gradientLayer.frame = CGRectMake(0, FirstCellHeight - 150, KScreenWidth , 150 );
    
    [self.contentView.layer insertSublayer:gradientLayer above:self.filmImageView.layer];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
