//
//  ProCenterViewcontrolelr.m
//  SingleProgrammersS
//
//  Created by 任前辈 on 15/11/23.
//  Copyright (c) 2015年 SingleProgrammers. All rights reserved.
//

#import "ProCenterViewcontrolelr.h"



#define KMoveWith  self.view.width

#define KSmallScrare   0.5

#define KMaxScare  (1+KSmallScrare)




#define  CenterType    YES

@interface ProCenterViewcontrolelr ()<UIScrollViewDelegate>
{
    BOOL _isTrainsAnimationing;
}

@property(nonatomic,strong)UIPanGestureRecognizer * panGesture;
@property(nonatomic,strong)UIButton * mengBan;


@end

@implementation ProCenterViewcontrolelr


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.responsePanGesture = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _isTrainsAnimationing = NO;
    //    self.view.backgroundColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    
}


-(void)setResponsePanGesture:(BOOL)responsePanGesture{
    
    _responsePanGesture = responsePanGesture;
    
    if (_responsePanGesture) {
        [self.view addGestureRecognizer:self.panGesture];
    }else{
        [self.view removeGestureRecognizer:self.panGesture];
        
    }
}

-(UIButton *)mengBan{
    
    if (_mengBan == nil) {
        _mengBan = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mengBan addTarget:self action:@selector(showCenter) forControlEvents:UIControlEventTouchUpInside];
        _mengBan.backgroundColor = [UIColor blackColor];
        _mengBan.frame = self.centerViewcontroller.view.bounds;
        self.mengBan.alpha = 0;
    }
    
    return _mengBan;
    
}

-(UIPanGestureRecognizer *)panGesture{
    
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        _panGesture.maximumNumberOfTouches = 1;
        
    }
    return _panGesture;
}




-(void)showCenter{
    
    [self showCenter:YES animation:YES];
    
}

-(void)initView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.leftViewcontroller viewWillAppear:YES];
    
    
    
    switch (self.type ) {
        case Scare:
        {
            
            
            self.leftViewcontroller.view.frame = CGRectMake(-self.view.width, 0, self.view.width, self.view.height);
            
            self.centerViewcontroller.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
            self.leftViewcontroller.view.transform = CGAffineTransformMakeScale(KMaxScare, KMaxScare);
            
            [self.centerViewcontroller.view addSubview:self.mengBan];
            
            
        }
            break;
        case Fold:
        {
            
            self.leftViewcontroller.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
            
            self.centerViewcontroller.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
            
        }
            break;
            
        default:
            break;
    }
    
    [self.centerViewcontroller viewDidAppear:YES];
    self.centerViewcontroller.view.hidden = NO;
    self.leftViewcontroller.view.hidden = YES;
    [self addChildViewController:self.centerViewcontroller];

    self.showCenter = YES;
    
}


-(void)setViewcontolelrs:(NSArray *)viewcontolelrs{
    
    for (UIViewController * vc in self.viewcontolelrs) {
        
        [vc.view removeFromSuperview];
        
        [vc removeFromParentViewController];
    }
    
    
    _viewcontolelrs  = viewcontolelrs;
    
    [self initView];
    
    [self addChild];
    
    
}


-(void)addChild{
    
    
    
    for (UIViewController * vc in self.viewcontolelrs) {
        
        [self.view addSubview:vc.view];
        
        
    }
    
    
    
    [self.view bringSubviewToFront:self.centerViewcontroller.view];
    
    
    
    
}



-(UIViewController *)leftViewcontroller{
    return self.viewcontolelrs[0];
    
}

-(UIViewController *)centerViewcontroller{
    
    return self.viewcontolelrs[1];
    
}





- (void)panView:(UIPanGestureRecognizer *)pan{
    
    if (_isTrainsAnimationing) {
        return ;
    }
    CGPoint point = [pan locationInView:self.view];
    
    
    
    
    static CGPoint startPoint ;
    
    
    switch (pan.state ) {
        case UIGestureRecognizerStateBegan:
        {
            startPoint = point;
            
            self.centerViewcontroller.view.hidden = NO;
            self.leftViewcontroller.view.hidden = NO;
            
            if (self.isShowCenter) {
                [self.leftViewcontroller viewWillAppear:YES];
                [self.centerViewcontroller viewWillDisappear:YES];
            }else{
                [self.centerViewcontroller viewWillAppear:YES];
                [self.leftViewcontroller viewWillDisappear:YES];
                
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            if (self.isShowCenter) {
                if (startPoint.x>100) {
                    return;
                }
            }else{
                
                if (startPoint.x<self.view.width - 100) {
                    return;
                }
            }
            
            
            float offset = point.x - startPoint.x;
            
            
            [self transFormWithRatio:offset];//设置偏移量
            
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
            if (self.isShowCenter) {
                if (startPoint.x>100) {
                    return;
                }
            }else{
                
                if (startPoint.x<self.view.width - 100) {
                    return;
                }
            }
            //趋势
            CGPoint velocityPoint = [pan velocityInView:self.view];
            
            float offset = point.x - startPoint.x;
            
            
            [self transFormWithRatio:offset];//设置偏移量
            
            startPoint = CGPointZero;
            
            if (velocityPoint.x>0) {
                
                [self showCenter:NO animation:YES];
            }else{
                [self showCenter:YES animation:YES];
                
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
    
}

//显示中间   是否有动画
- (void)showCenter:(BOOL)center  animation:(BOOL)animation{
    
    
    _isTrainsAnimationing = YES;
    
    if ([self.delegate respondsToSelector:@selector(willShowViewControlelerAtIndex:inCenterViewController:)]) {
        
        [self.delegate willShowViewControlelerAtIndex:center?1:0 inCenterViewController:self];
        
        
    }
    
    switch (self.type ) {
        case Scare:
        {
            //放大缩小效果
            if (animation) {
                
                if (center) {
                    
                    
                    
                    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    
                    scaleAnimation.fromValue = @(self.leftViewcontroller.view.transform.a);
                    
                    scaleAnimation.toValue = @(KMaxScare);
                    
                    scaleAnimation.repeatCount = 1;
                    scaleAnimation.duration = 0.5;
                    
                    CABasicAnimation * translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
                    
                    translateAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(self.leftViewcontroller.view.transform.tx, self.leftViewcontroller.view.transform.ty)];
                    
                    translateAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
                    
                    translateAnimation.repeatCount = 1;
                    translateAnimation.duration = 0.5;
                    
                    
                    CAAnimationGroup * group = [CAAnimationGroup animation];
                    
                    group.animations = @[scaleAnimation,translateAnimation];
                    group.duration = 2;
                    
                    [self.leftViewcontroller.view.layer addAnimation:group forKey:@"group"];
                    
                    self.leftViewcontroller.view.transform = CGAffineTransformMakeScale(KMaxScare, KMaxScare);
                    
                    
                    
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        self.centerViewcontroller.view.transform = CGAffineTransformIdentity;
                        
                        self.mengBan.alpha = 0;
                        
                    }completion:^(BOOL finished) {
                        self.showCenter = YES;
                        
                        if ([self.delegate respondsToSelector:@selector(didShowViewControlelerAtIndex:inCenterViewController:)]) {
                            
                            [self.delegate didShowViewControlelerAtIndex:1 inCenterViewController:self];
                            
                        }
                        
                        _isTrainsAnimationing = NO;

                    }];
                    
                    
                }else{
                    
                    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    
                    scaleAnimation.fromValue = @(self.leftViewcontroller.view.transform.a);
                    
                    scaleAnimation.toValue = @(1);
                    
                    scaleAnimation.repeatCount = 1;
                    scaleAnimation.duration = 0.5;
                    
                    CABasicAnimation * translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
                    
                    translateAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(self.leftViewcontroller.view.transform.tx, self.leftViewcontroller.view.transform.ty)];
                    
                    translateAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(self.view.width, 0)];
                    
                    translateAnimation.repeatCount = 1;
                    translateAnimation.duration = 0.5;
                    
                    
                    CAAnimationGroup * group = [CAAnimationGroup animation];
                    
                    group.animations = @[scaleAnimation,translateAnimation];
                    
                    group.duration = 2;
                    
                    [self.leftViewcontroller.view.layer addAnimation:group forKey:@"group"];
                    
                    
                    self.leftViewcontroller.view.transform = CGAffineTransformMakeTranslation(self.view.width, 0);
                    
                    
                    
                    
                    
                    
                    
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        CGAffineTransform scareTransform = CGAffineTransformMakeScale(KSmallScrare  , KSmallScrare);
                        
                        self.centerViewcontroller.view.transform = CGAffineTransformTranslate(scareTransform, (1-KSmallScrare)*KMoveWith, 0);
                        
                        self.mengBan.alpha = 0.4;
                        
                    } completion:^(BOOL finished) {
                        
                        self.showCenter = NO;
                        if ([self.delegate respondsToSelector:@selector(didShowViewControlelerAtIndex:inCenterViewController:)]) {
                            
                            [self.delegate didShowViewControlelerAtIndex:0 inCenterViewController:self];
                            
                        }
                        _isTrainsAnimationing = NO;

                    }];
                    
                }
                
            }
            
        }
            break;
        case Fold:
        {
            
            
            //折叠效果
            
            if (center) {
                
                
                if (animation) {
                    
                
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:3 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self rotationWithAngle:0];
                    
                } completion:^(BOOL finished) {
                    [self complicateShowCenter:center];


                }];
                
                }else {
                    [self rotationWithAngle:0];
                    [self complicateShowCenter:center];

                }
                
            }else{
                
                if (animation) {
                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:3 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [self rotationWithAngle:M_PI_2];
                        
                    } completion:^(BOOL finished) {
                        
                        [self complicateShowCenter:center];
                        
                    }];
                }else{
                    [self rotationWithAngle:M_PI_2];
                    [self complicateShowCenter:center];

                }
                
                
            }
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}

-(void)complicateShowCenter:(BOOL)show{
   
    _isTrainsAnimationing = NO;

    self.showCenter = show;

    if (show) {
        
        if ([self.delegate respondsToSelector:@selector(didShowViewControlelerAtIndex:inCenterViewController:)]) {
            
            [self.delegate didShowViewControlelerAtIndex:1 inCenterViewController:self];
            
        }
        
        [self.centerViewcontroller viewDidAppear:YES];
        self.centerViewcontroller.view.userInteractionEnabled = YES;
        self.centerViewcontroller.view.layer.transform = CATransform3DIdentity;
        
        [self.leftViewcontroller viewDidDisappear:YES];
        self.leftViewcontroller.view.userInteractionEnabled = NO;
        
        self.leftViewcontroller.view.hidden = YES;
        self.centerViewcontroller.view.hidden = NO;
        [self.leftViewcontroller removeFromParentViewController];
        [self addChildViewController:self.centerViewcontroller];
    }
    else {
        
        if ([self.delegate respondsToSelector:@selector(didShowViewControlelerAtIndex:inCenterViewController:)]) {
            
            [self.delegate didShowViewControlelerAtIndex:0 inCenterViewController:self];
            
        }
        [self.leftViewcontroller viewDidAppear:YES];
        self.leftViewcontroller.view.layer.transform = CATransform3DIdentity;

        [self.centerViewcontroller viewDidDisappear:YES];
        
        self.centerViewcontroller.view.userInteractionEnabled = NO;
        self.leftViewcontroller.view.userInteractionEnabled = YES;
       
        self.centerViewcontroller.view.hidden = YES;
        self.leftViewcontroller.view.hidden = NO;

        [self.centerViewcontroller removeFromParentViewController];
        [self addChildViewController:self.leftViewcontroller];

    }
}

/**
 *  设置 变形
 *
 *  @param ratio  偏移量
 */
-(void)transFormWithRatio:(float)offset{
    
    switch (self.type ) {
        case Scare:
        {
            //侧滑放大缩小效果
            
            
            float scare = 1- offset/KMoveWith;//
            
            
            float smallScrare = scare > KSmallScrare ? scare : KSmallScrare;
            
            
            
            if (_showCenter) {//如果当前 是显示右边
                
                if (offset<0) {
                    return;
                }
                
                
                
            }else{
                
                if (offset>0) {
                    return;
                }
                
                scare = - offset/KMoveWith ;
                
                smallScrare = (scare + KSmallScrare) < 1 ? scare+KSmallScrare : 1;
                
                
            }
            
            float   leftScare = KMaxScare - (1 - smallScrare)*2 * (KMaxScare - 1);
            
            
            
            CGAffineTransform scareTransform = CGAffineTransformMakeScale(smallScrare  , smallScrare);
            
            self.centerViewcontroller.view.transform = CGAffineTransformTranslate(scareTransform, (1-smallScrare)*self.view.width, 0);
            
            
            
            
            CGAffineTransform leftscareTransform = CGAffineTransformMakeScale(leftScare  , leftScare);
            
            
            self.leftViewcontroller.view.transform = CGAffineTransformTranslate(leftscareTransform, self.view.width*(KMaxScare - leftScare)*2, 0);
            
        }
            break;
        case Fold:
        {
            
            
            float totalWidth = 150;
            //滑动的百分比
            float radio = (offset/totalWidth < 1)?offset/totalWidth:1;
            
            
            if (offset<0) {
                radio = ((totalWidth+offset)/totalWidth > 0)?(totalWidth+offset)/totalWidth:0;
            }
            
            
            float angle = M_PI/2*radio;
            
            if (_showCenter && offset<0) {
                return;
            }
            if (_showCenter == NO && offset>0) {
                return;
            }
            
            
            [self rotationWithAngle:angle];
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}





//    CALayer默认使用正交投影，因此没有远小近大效果，而且没有明确的API可以使用透视投影矩阵。所幸可以通过矩阵连乘自己构造透视投影矩阵。构造透视投影矩阵的代码如下：
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;     // 设置M34就有立体感(近大远小)。 -1 / z ,z表示观察者在z轴上的值,z越小，看起来离我们越近，东西越大。
    
    
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}



CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}




//设置旋转角度
- (void)rotationWithAngle:(float)angle{
    
    CATransform3D move0 = CATransform3DMakeTranslation(0, 0, self.view.frame.size.width/2);
    CATransform3D move1 = CATransform3DMakeTranslation(0, 0, self.view.frame.size.width/2);
    
    CATransform3D back0 = CATransform3DMakeTranslation(0, 0, -self.view.frame.size.width/2);
    CATransform3D back1 = CATransform3DMakeTranslation(0, 0, -self.view.frame.size.width/2);
    
    CATransform3D rotate0 = CATransform3DMakeRotation(angle, 0, 1, 0);
    CATransform3D rotate1 = CATransform3DMakeRotation(-M_PI_2  + angle, 0, 1, 0);
    
    CATransform3D mat0 = CATransform3DConcat(CATransform3DConcat(move0, rotate0), back0);
    CATransform3D mat1 = CATransform3DConcat(CATransform3DConcat(move1, rotate1), back1);
    
    
    self.centerViewcontroller.view.layer.transform = CATransform3DPerspect(mat0, CGPointZero, 1000);
    self.leftViewcontroller.view.layer.transform = CATransform3DPerspect(mat1, CGPointZero, 1000);
    
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
