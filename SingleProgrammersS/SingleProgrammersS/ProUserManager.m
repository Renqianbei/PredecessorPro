//
//  ProUserManager.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "ProUserManager.h"

@implementation ProUserManager


+(instancetype)shareInstance{
    
    static ProUserManager  * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ProUserManager alloc] init];
        
    });
    
    return manager;
}

@end
