//
//  RTRefreshControl.h
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTRefreshControl : UIRefreshControl

@property (strong, nonatomic) UIImageView *loadIndicator;
@property (strong, nonatomic) UIView *refreshLoadingView;

- (void)pull;
- (void)setup:(float)width color:(UIColor*)color;

@end
