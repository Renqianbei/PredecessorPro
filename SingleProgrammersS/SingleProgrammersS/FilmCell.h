//
//  FilmCell.h
//  Film_1502
//
//  Created by 任前辈 on 15/11/10.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmModel.h"
@interface FilmCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


-(void)refreshWithModel:(FilmModel *)model;

@end
