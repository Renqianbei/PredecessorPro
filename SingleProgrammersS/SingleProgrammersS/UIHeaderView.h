//
//  UIHeaderView.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultHeight  60

#import "ProFilmDetailModel.h"
@interface UIHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;


@property(nonatomic,strong)DetailInfoModel * model;
@property (weak, nonatomic) IBOutlet UIView *backView;


@property(nonatomic,strong)CAGradientLayer * gradientlayer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;

-(void)refreshLayer;
@property (weak, nonatomic) IBOutlet UIButton *foreshowButton;

@end
