//
//  FlipView.h
//  Text翻页折叠效果
//
//  Created by 任前辈 on 15/11/24.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PREFlipView;

@protocol FlipDelegate <NSObject>
//已经滚到上面时
-(void)flipToTop:(BOOL)top view:(PREFlipView *)flipView;

//将要滚到上面时
-(void)willFlipToTop:(PREFlipView *)flipView;

@end

@interface PREFlipView : UIView

@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,assign)BOOL isOnTop;

@property(nonatomic,weak)id<FlipDelegate>delegate;

@property (nonatomic,weak)id model;

@end
