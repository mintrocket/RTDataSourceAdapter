//
//  RTAdapterItem.h
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAdapterItem : NSObject

@property (nonatomic) NSString *itemID;
@property (nonatomic) id itemValue;
@property (assign) BOOL isSelected;

@property (weak,nonatomic) NSIndexPath *index;

-(instancetype)initWithID:(NSString *)itemID
                    value:(id)itemValue;

-(instancetype)initWithID:(NSString *)itemID
                    value:(id)itemValue
                 selected:(BOOL)selectedValue;

@end
