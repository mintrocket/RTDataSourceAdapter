//
//  UIImageView+RTAnimating.m
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "UIImageView+RTAnimating.h"

@implementation UIImageView (Animating)

- (void)rt_startAnimating
{
    self.hidden=false;
    CABasicAnimation *fullRotation  = [[CABasicAnimation alloc] init];//CABasicAnimation(keyPath:"transform.rotation");
    fullRotation.keyPath = @"transform.rotation";
    fullRotation.fromValue = [NSNumber numberWithDouble:0];
    fullRotation.toValue = [NSNumber numberWithDouble:((360*M_PI)/180.0)];
    fullRotation.duration = 0.5;
    fullRotation.repeatCount = HUGE;
    [self.layer addAnimation:fullRotation forKey:@"360"];
}

- (void)rt_stopAnimating
{
    [self.layer removeAllAnimations];
    self.hidden = true;
}

@end
