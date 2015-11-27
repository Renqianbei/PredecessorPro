//
//  UIImage+Pro_Image.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/27.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "UIImage+Pro_Image.h"

@implementation UIImage (Pro_Image)


+(UIImage *)imageWithColor:(UIColor *)color{
    
  
    CGRect rect= CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
