//
//  ProUserManager.h
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/12/2.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProChater.h"
#import "ProManagerProtocol.h"

@interface ProUserManager : NSObject<ProManagerProtocol>

@property(nonatomic,strong)ProChater * user;




@end
