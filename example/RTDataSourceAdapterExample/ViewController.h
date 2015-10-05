//
//  ViewController.h
//  RTDataSourceAdapterExample
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTDataSourceAdapter.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) RTDataSourceAdapter *adapter;

@end

