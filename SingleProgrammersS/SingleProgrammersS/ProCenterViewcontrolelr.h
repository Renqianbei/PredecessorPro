//
//  ProCenterViewcontrolelr.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/23.
//  Copyright (c) 2015年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"
#import "ProCenterViewcontrolelr.h"

typedef NS_ENUM(NSInteger,SHowType){
    
    Scare ,//侧滑样式
    Fold  //立体样式
};

@class ProCenterViewcontrolelr;

@protocol CenterViewDelegate <NSObject>
/**
 *  视图将要切换到另一个时
 *
 *  @param index 切换的控制器所在位置
 *  @param vc    当前容器视图控制器
 */
-(void)willShowViewControlelerAtIndex:(NSInteger)index inCenterViewController:(ProCenterViewcontrolelr *)vc;

/**
 *  视图已经切换到另一个时
 *
 *  @param index 切换的控制器所在位置
 *  @param vc     当前容器视图控制器
 */
-(void)didShowViewControlelerAtIndex:(NSInteger)index inCenterViewController:(ProCenterViewcontrolelr *)vc;


@end


@interface ProCenterViewcontrolelr : UIViewController


@property(nonatomic,strong)NSArray * viewcontolelrs;

@property(nonatomic,assign,getter=isShowCenter)BOOL showCenter;

@property(nonatomic,assign)SHowType type;

@property(nonatomic,weak)id<CenterViewDelegate>delegate;

/**
 *  是否响应侧滑手势
 */
@property(nonatomic,assign)BOOL responsePanGesture;

-(UIViewController *)leftViewcontroller;
-(UIViewController *)centerViewcontroller;





@end
