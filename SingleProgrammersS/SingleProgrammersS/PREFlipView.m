//
//  FlipView.m
//  Text翻页折叠效果
//
//  Created by 任前辈 on 15/11/24.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "PREFlipView.h"

@interface PREFlipView()
{
    float _height;
    
}
@end


@implementation PREFlipView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    
    if (self) {
        
        self.layer.anchorPoint = CGPointMake(0.5, 0);

        UIPanGestureRecognizer  * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        
        self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        
        [self addGestureRecognizer:pan];
        
        _height = self.frame.size.height;
        
        self.isOnTop = NO;
    }
    return self;
    
}


- (void)panView:(UIPanGestureRecognizer *)pan{
    
    
    CGPoint point  = [pan locationInView:self.superview];
    
    
    static  CGPoint startPoint;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            startPoint = point;
        }
            break;
         
        case UIGestureRecognizerStateChanged:
        {
            
            float offset = point.y - startPoint.y;
            
            if (offset>0) {//向下翻
                
                if (self.isOnTop == NO) {
                    return;
                }
                offset =  offset - _height;
                
            }else {//向上翻
                
                if (self.isOnTop == YES) {
                    return;
                }
            }
            
            float radio = -offset/_height;
            
            float angle = M_PI * radio;
            
            [self transToangle:angle];
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            startPoint = CGPointZero;
            
            CGPoint velocityPoint = [pan velocityInView:self.superview];
            
            if (velocityPoint.y<0) {
                [self flipToTop:YES];
            }else{
                [self flipToTop:NO];
            }
        }
            break;
        default:
            break;
    }
    
}


-(void)flipToTop:(BOOL)top{
    
    
    float damping = 1;
    float velocity = 0;
    float duration = 0.3;
    if (top) {
        damping = 0.5;
        velocity = 1;
        duration = 0.3;    }
    
    //无弹性动画
    [UIView animateWithDuration:duration animations:^{
              if (top) {
                  [self transToangle:M_PI];
                  self.alpha = 0.5;
              }else{
                  [self transToangle:0];
                  self.alpha = 1;
                  
              }
          } completion:^(BOOL finished) {
              
              if ([self.delegate respondsToSelector:@selector(flipToTop:view:)]) {
                  
                  [self.superview addSubview:self];
                  [self.delegate flipToTop:top view:self];
              }
              
              self.isOnTop = top;
          }];
    
    return;
    
    //弹性动画
     [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping
           initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
         if (top) {
             [self transToangle:M_PI];
             self.alpha = 0.5;
         }else{
             [self transToangle:0];
             self.alpha = 1;

         }
     } completion:^(BOOL finished) {
      
         if ([self.delegate respondsToSelector:@selector(flipToTop:view:)]) {
             
             [self.superview addSubview:self];
             [self.delegate flipToTop:top view:self];
         }
         
         self.isOnTop = top;
     }];
    
    
}


-(void)transToangle:(float)angle{
    
    CATransform3D scares = CATransform3DIdentity;
    
    scares.m34 = -1/1000.0;
    
    self.layer.transform = CATransform3DRotate(scares, angle, 1, 0, 0);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
