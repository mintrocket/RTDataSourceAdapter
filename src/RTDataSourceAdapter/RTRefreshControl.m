//
//  RTRefreshControl.m
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
///

#import "RTRefreshControl.h"

@implementation RTRefreshControl

- (void)setup:(float)width color:(UIColor *)color
{
    self.refreshLoadingView = [[UIView alloc] initWithFrame:self.bounds];
    self.refreshLoadingView.backgroundColor = [UIColor clearColor];
    
    self.loadIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rt_loader"]];
    self.loadIndicator.image = [self.loadIndicator.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.loadIndicator.tintColor = color;
    self.loadIndicator.center = CGPointMake(width/2.0, 30);
    [self.refreshLoadingView addSubview:self.loadIndicator];
    
    self.refreshLoadingView.clipsToBounds = YES;
    
    self.tintColor = [UIColor clearColor];
    
    [self addSubview:self.refreshLoadingView];
    
}


- (void)pull
{
    CGFloat pullDistance = MAX(0.0, -self.frame.origin.y);
    CGFloat pullRatio = MIN(MAX(pullDistance, 0.0), 100.0) / 100.0;
    
    if (pullRatio < 1){
        self.loadIndicator.transform = CGAffineTransformMakeScale(pullRatio, pullRatio);
        
    }
    
    CGRect refreshBounds = self.bounds;
    refreshBounds.size.height = pullDistance;
    
    self.refreshLoadingView.frame = refreshBounds;
    
    
    if (pullRatio == 1) {
        [self animateRefreshView];
    }
}

- (void)animateRefreshView
{
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.loadIndicator setTransform:CGAffineTransformRotate(self.loadIndicator.transform, M_PI_2)];
                     }
                     completion:^(BOOL finished) {
                         if (self.isRefreshing) {
                             [self animateRefreshView];
                         }
                     }];
}


@end
