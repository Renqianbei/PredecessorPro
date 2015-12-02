//
//  ChatCell.h
//  CellDIY自定制样式
//
//  Created by 任前辈 on 15/10/28.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageModel.h"

@interface ChatCell : UITableViewCell

@property(nonatomic,strong)UIView * leftView;//左边视图
@property(nonatomic,strong)UIView * rightView;//右边视图

@property(nonatomic,strong)UILabel * contetlabel;
//内容
@property(nonatomic,strong)UIImageView * headImageView;//头像

@property(nonatomic,strong)UIImageView * backGroundImageView;//气泡背景


//刷新cell
-(void)refreshCell:(MessageModel *)model;
//返回cell的高度
+(float)cellHeightWith:(MessageModel *)model;




@end
