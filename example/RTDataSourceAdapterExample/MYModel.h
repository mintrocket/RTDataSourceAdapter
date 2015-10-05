//
//  MYModel.h
//  RTDataSourceAdapterExample
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYModel : NSObject

@property (nonatomic) int number;
@property (nonatomic) UIColor *color;

- (instancetype)initWithNumber:(int)number;

@end
