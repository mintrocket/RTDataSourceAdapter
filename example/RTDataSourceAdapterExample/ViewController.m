//
//  ViewController.m
//  RTDataSourceAdapterExample
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "ViewController.h"
#import "MYModel.h"
#import "MYTableViewCell.h"
#import "MYSpecalFirstCell.h"

@interface ViewController ()
{
    NSArray *cellIdentifiers;
    int pageCount;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageCount = 0;
    
    cellIdentifiers = @[ NSStringFromClass([MYTableViewCell class]), NSStringFromClass([MYSpecalFirstCell class])];
    self.adapter = [[RTDataSourceAdapter alloc] init];
   
    self.myTable.tintColor = [UIColor redColor];
    
    [self.adapter registerTableView:self.myTable
                    cellIdentifiers:cellIdentifiers
                   addPullToRefresh:YES
                 pageLoadingEnabled:YES];
    
    self.adapter.deselectable = YES;
    
    
    __weak typeof(self)weakSelf = self;
    [self.adapter setSelectHandler:^(RTAdapterItem *selectedObject, NSIndexPath *indexPath) {
       [[[UIAlertView alloc] initWithTitle:@"Selected"
                                   message:[NSString stringWithFormat:@"%i", ((MYModel *)selectedObject.itemValue).number ]
                                 delegate:nil
                        cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];
    }];
    
    [self.adapter setPullToRefreshHandler:^{
        [weakSelf refreshAdapter];
    }];
    
    [self.adapter setLoadMoreHandler:^{
        [weakSelf moreContent];
    }];
    
    [self refreshAdapter];
    
}

- (void)moreContent
{
    for(int i = -1; ++i < 10;)
    {
        [self.adapter.content addItem:cellIdentifiers[0]
                                value:[[MYModel alloc] initWithNumber:i+(pageCount * 10)]];
    }
    
    pageCount++;
    
    [self.adapter reloadData];
}

- (void)refreshAdapter
{
    pageCount = 0;
    
    [self.adapter.content clear];
    
    [self.adapter.content addItem:cellIdentifiers[1]
                            value:nil];
    
    
    
    [self moreContent];
    
}


@end
