//
//  UIView+FastFrame.h
//  UITabBarController初识
//
//  Created by 任前辈 on 15/10/20.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FastFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign, readonly) CGFloat minX;
@property (nonatomic, assign, readonly) CGFloat maxX;

@property (nonatomic, assign, readonly) CGFloat minY;
@property (nonatomic, assign, readonly) CGFloat maxY;

@property (nonatomic, assign, readonly) CGFloat midX;
@property (nonatomic, assign, readonly) CGFloat midY;

@property (nonatomic, assign, readonly) CGFloat centerX;
@property (nonatomic, assign, readonly) CGFloat centerY;


@end
