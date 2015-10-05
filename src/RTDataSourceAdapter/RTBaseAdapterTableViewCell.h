//
//  RTBaseAdapterTableViewCell.h
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTCellHeight <NSObject>

+ (CGFloat)heightFromCellContent:(id)content;

@end

@interface RTBaseAdapterTableViewCell : UITableViewCell<RTCellHeight>

@property (assign, nonatomic) BOOL isLast;
@property (assign, nonatomic) BOOL isFirst;

- (void)cellContent:(id)content;

@end
