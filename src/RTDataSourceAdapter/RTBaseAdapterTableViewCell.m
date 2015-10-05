//
//  RTBaseAdapterTableViewCell.m
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "RTBaseAdapterTableViewCell.h"

@implementation RTBaseAdapterTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)cellContent:(id)content
{

}

+ (CGFloat)heightFromCellContent:(id)content
{
    return 44;
}

@end
