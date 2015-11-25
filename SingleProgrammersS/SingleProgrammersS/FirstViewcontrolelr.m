//
//  FirstViewcontrolelr.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/23.
//  Copyright (c) 2015年 SingleProgrammers. All rights reserved.
//

#import "FirstViewcontrolelr.h"

@interface FirstViewcontrolelr ()

@end

@implementation FirstViewcontrolelr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:imageView];
    
    imageView.image = [UIImage imageNamed:@"11_2.jpg"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
