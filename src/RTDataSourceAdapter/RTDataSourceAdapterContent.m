//
//  RTDatasourceAdapterContent.m
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "RTDataSourceAdapterContent.h"

@implementation RTDataSourceAdapterContent

- (instancetype)initWithRTAdapterItems:(NSArray *)items
{
    self = [super init];
    
    if (self){
        self.items = [[NSMutableArray alloc] initWithArray:items];
    }
    
    return self;
}

- (id)getItem:(NSInteger)position
{
    return self.items.count > 0 ? self.items[position] : nil;
}

- (void)addItem:(NSString *)cellIdentifier value:(id)value
{
    if (!self.items) self.items = [[NSMutableArray alloc] init];
        
    [self.items addObject:[[RTAdapterItem alloc] initWithID:cellIdentifier value:value]];
}

- (void)addItem:(RTAdapterItem *)item
{
    if (!self.items) self.items = [[NSMutableArray alloc] init];
    
    [self.items addObject:item];
}

- (void)insertItem:(RTAdapterItem *)item atIndex:(NSUInteger)position
{
    if (!self.items) self.items = [[NSMutableArray alloc] init];
    
    [self.items insertObject:item atIndex:position];
}

- (void)removeItem:(RTAdapterItem *)item
{
    [self.items removeObject:item];
}

- (void)clear
{
   if (self.items) [self.items removeAllObjects];
}

- (NSInteger)getCount
{
    return self.items.count;
}

@end
