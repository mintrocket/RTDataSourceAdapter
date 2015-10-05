//
//  RTDatasourceAdapterContent.h
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAdapterItem.h"


@interface RTDataSourceAdapterContent : NSObject

@property (strong, nonatomic) NSMutableArray *items;

- (instancetype)initWithRTAdapterItems:(NSArray *)items;

- (NSInteger)getCount;
- (id)getItem:(NSInteger)position;
- (void)addItem:(NSString *)cellIdentifier value:(id)value;
- (void)addItem:(RTAdapterItem *)item;
- (void)removeItem:(RTAdapterItem *)item;
- (void)clear;
- (void)insertItem:(RTAdapterItem *)item atIndex:(NSUInteger)position;

@end
