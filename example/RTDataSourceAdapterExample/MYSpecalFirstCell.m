//
//  MYSpecalFirstCell.m
//  RTDataSourceAdapterExample
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "MYSpecalFirstCell.h"

@implementation MYSpecalFirstCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(CGFloat)heightFromCellContent:(id)content
{
    return 80;
}

@end
