//
//  UIColor+UIColor_category.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/25.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_category)

/**
 *  随机颜色
 *
 *  @return  随机颜色
 */
+(UIColor *)randColor;

/**
 *  设计师颜色
 *
 *  @return 设计师颜色
 */
+(UIColor *)systemColor;

/**
 *  用户偏好颜色
 *
 *  @return 用户偏好颜色
 */
+(UIColor *)userDefaultColor;

@end
