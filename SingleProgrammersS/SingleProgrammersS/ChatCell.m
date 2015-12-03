//
//  ChatCell.m
//  CellDIY自定制样式
//
//  Created by 任前辈 on 15/10/28.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "ChatCell.h"
#define   HeadImageWidth  60

#define KscreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //自定义相关视图
        [self initView];
    }
    
    return self;
    
}

//初始化视图 
-(void)initView{
    
    _contetlabel = [[UILabel alloc] init];
    _contetlabel.numberOfLines = 0;
    _headImageView = [[UIImageView alloc] init];
    _backGroundImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_headImageView];
    [self.contentView addSubview:_backGroundImageView];
    
    [self.contentView addSubview:_contetlabel];

    
    
}

//刷新内容
-(void)refreshCell:(MessageModel *)model{
    
    _contetlabel.text = model.content;
    _headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",model.name]];
    
    if (model.isSelf) {
        UIImage * image = [UIImage imageNamed:@"talk2_bg"];
        
        image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];//设置拉伸方式
        
        _backGroundImageView.image = image;
        
    }else{
        
        UIImage * image = [UIImage imageNamed:@"talk1_bg"];
        
        image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];//设置拉伸方式 将距离图片左右边为10  距离上边下边为10 的位置 进行拉伸

        _backGroundImageView.image = image;
    }
    
    //刷新子视图位置
    [self refreshFrameModel:model];

    
}

//刷新子视图位置
-(void)refreshFrameModel:(MessageModel*)model{
    
    float cellHeight = [ChatCell cellHeightWith:model];//得到cell的高度

   
    if (model.isSelf) {
        //设置头像的位置
        _headImageView.frame = CGRectMake(10, cellHeight - 10 - HeadImageWidth, HeadImageWidth, HeadImageWidth);
        
        //label距离左边的距离
        float originX = _headImageView.frame.origin.x + HeadImageWidth + 10;
       //label的宽度
        float width =  KscreenWidth - originX - 10;
        //得到label的大小
        CGSize size = [ChatCell heightWithText:model.content width:width];
        
        width = size.width;//重新设置宽度
        //设置label的大小
        _contetlabel.frame = CGRectMake(originX, 10, width , size.height);
        
        //设置背景图的大小
        CGRect frame = _contetlabel.frame;
        frame.origin.x -= 5;
        frame.size.width += 5;
        //背景图的位置在lable的左边一点
        _backGroundImageView.frame = frame ;
        
    }else{
        
//        你说
        
        //设置头像的位置
        _headImageView.frame = CGRectMake(KscreenWidth - HeadImageWidth - 10, cellHeight - 10 - HeadImageWidth, HeadImageWidth, HeadImageWidth);
        
        //label的宽度
        float width = _headImageView.frame.origin.x - 10 - 10;
        
        CGSize size = [ChatCell heightWithText:model.content width:width];
        
        width = size.width;//label真正的宽度
        
        //label的横坐标
        float originx = _headImageView.frame.origin.x - 10 - width;
        
        _contetlabel.frame = CGRectMake(originx, 10, width, size.height);
        
        _backGroundImageView.frame = _contetlabel.frame;
        
    }
  
    
    
}


+(float)cellHeightWith:(MessageModel *)model{
    
    //label的宽度
   float width = KscreenWidth - HeadImageWidth - 10 - 10 - 10;
    //label的高度 由文字和它的宽度决定
   float labelHeight = [self heightWithText:model.content width:width].height;
    
    //返回cell的高度
    return labelHeight + 10 + 10;
}

//有文字   还要限制最大的宽度  可以得到文字显示所需要的高度

+(CGSize)heightWithText:(NSString *)text width:(float)maxWidth {
    
    //得到 文字的高度
    CGSize size = CGSizeZero;
    
    
    if ([[UIDevice currentDevice] systemVersion].floatValue <= 7.0) {
        //如果系统版本小于 7.0 
        size =  [text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) ];
        
    }else{
        //ios 7 之后替代上面的方法
       CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
        
        size = rect.size;
        
    }
    
   
    
    
//    NSLog(@"%@",NSStringFromCGSize(size));
    if (size.height < 50) {//如果算出的高度小于50
       
        size.height = 50;
        
    }
    
    
   return size;
    
    
}

@end
