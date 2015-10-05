//
//  MYTableViewCell.m
//  RTDataSourceAdapterExample
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "MYTableViewCell.h"
#import "MYModel.h"

@implementation MYTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - RTBaseAdapterTableViewCell methods

- (void)cellContent:(MYModel *)content
{
    self.myLabel.text =  [NSString stringWithFormat:@"%i", content.number];
    self.myLabel.textColor = content.color;
}

+ (CGFloat)heightFromCellContent:(MYModel *)content
{
    // calculate height
    
    return 150;
}

@end
