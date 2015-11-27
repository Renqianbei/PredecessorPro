//
//  UIHeaderView.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/26.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "UIHeaderView.h"
#import "CommonMacro.h"
#import <UIImageView+AFNetworking.h>

@implementation UIHeaderView

-(void)awakeFromNib{
    
    self.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageView.clipsToBounds = YES;
    
    /**
     *  修改样式
     */
    
    self.foreshowButton.layer.cornerRadius = 45/2.0;
    
    self.foreshowButton.layer.borderWidth = 1;
    self.foreshowButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.foreshowButton.layer.masksToBounds = YES;
    
}

-(CAGradientLayer *)gradientlayer{
    
    if (_gradientlayer == nil) {
        
        // 创建渐变图层
        CAGradientLayer *shadomLayer = [CAGradientLayer layer];
        // 设置渐变颜色
        shadomLayer.colors = @[(id)[[UIColor colorWithWhite:0 alpha:0]CGColor],(id)[[UIColor blackColor] CGColor]];
        
        
        _gradientlayer = shadomLayer;
        
    }
    return _gradientlayer;
}

-(void)refreshLayer{
    
    [self.gradientlayer removeFromSuperlayer];//移除这个渐变层
    self.gradientlayer = nil;//清空渐变层
    /**
     *  为什么要 移除 清空 重新创建渐变层？  原因  修改渐变层的frame 他重新绘制比较慢，会出现视觉卡顿效果  经过测试 重新创建 不会有显示顿一下的感觉
     
     */
    
    float height = 181 + self.labelHeight.constant - defaultHeight;
    
    self.gradientlayer.frame = CGRectMake(0, 0, self.width, height);
    
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
    
    [self refreshLayer];

}




@end
