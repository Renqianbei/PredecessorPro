//
//  UIHeaderView.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "UIHeaderView.h"
#import <UIImageView+AFNetworking.h>

@implementation UIHeaderView

-(void)awakeFromNib{
    
    self.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageView.clipsToBounds = YES;
    
    // 创建渐变图层
    CAGradientLayer *shadomLayer = [CAGradientLayer layer];
    // 设置渐变颜色
    shadomLayer.colors = @[(id)[UIColor clearColor],(id)[[UIColor blackColor] CGColor]];
    shadomLayer.frame = self.backView.bounds;
    // 设置不透明度 0
//    shadomLayer.opacity = 0;
    self.gradientlayer = shadomLayer;
    
    [self.backView.layer insertSublayer:self.gradientlayer atIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setModel:(DetailInfoModel *)model{
    
    [self.imageView setImageWithURL:[NSURL URLWithString:model.base_info.poster_url]];

    self.title.text = [NSString stringWithFormat:@"%@  导演：%@",model.base_info.country,model.base_info.directors];
    self.content.text = model.base_info.desc;
    

}


-(void)refreshGradientLayer{
    
    self.gradientlayer.frame = CGRectMake(0, 0, self.frame.size.width, 181 + self.labelHeight.constant - defaultHeight);
}


@end
