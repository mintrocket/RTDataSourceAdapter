//
//  RTAdapterItem.m
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "RTAdapterItem.h"

@implementation RTAdapterItem

- (instancetype)initWithID:(NSString *)itemID value:(id)itemValue
{
    self = [super init];
    
    if (self) {
        self.itemID = itemID;
        self.itemValue = itemValue;
    }
    
    return self;
}

- (instancetype)initWithID:(NSString *)itemID
                     value:(id)itemValue
                  selected:(BOOL)selectedValue
{
    self = [self initWithID:itemID value:itemID];
    
    if (self) {
        self.isSelected = selectedValue;
    }
    
    return self;
}

@end
