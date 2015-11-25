//
//  UIColor+UIColor_category.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/25.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "UIColor+UIColor_category.h"

@implementation UIColor (UIColor_category)


+(UIColor *)randColor{
    
    return [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
}

+(UIColor *)systemColor{
    
    return [UIColor blackColor];
}



+(UIColor *)userDefaultColor{
    
    return [UIColor redColor];
    
}
@end
