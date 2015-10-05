//
//  RTDatasourceAdapter.h
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTDataSourceAdapterContent.h"
#import "RTRefreshControl.h"


typedef void (^RTselectHandler)(id selectedObject, NSIndexPath *indexPath);
typedef void (^RTvoidHandler)(void);
typedef void (^RTwillDisplayCellHandler)(id selectedObject, NSIndexPath *indexPath);
typedef void (^RTdidEndDisplayingCellHandler)(id selectedObject, NSIndexPath *indexPath);

@interface RTDataSourceAdapter : NSObject<UITableViewDelegate, UITableViewDataSource>
{
    RTRefreshControl *refreshControl;
}

@property (strong, nonatomic) RTDataSourceAdapterContent *content;
@property (assign, nonatomic) BOOL deselectable;
@property (assign, nonatomic) BOOL pageLoadingEnabled;
@property (nonatomic) float pullToRefreshWidth;

- (instancetype)initWithRTAdapterItems:(NSArray *)items;

- (void)setPullToRefreshHandler:(RTvoidHandler)refresh;
- (void)setLoadMoreHandler:(RTvoidHandler)load;
- (void)setSelectHandler:(RTselectHandler)selected;
- (void)setWillDisplayCellHandler:(RTwillDisplayCellHandler)willDisplay;
- (void)setDidEndDisplayingCellHandler:(RTdidEndDisplayingCellHandler)endDisplaying;

- (void)registerTableView:(UITableView *)tableView
      cellIdentifier:(NSString *)identifier
    addPullToRefresh:(BOOL)value
  pageLoadingEnabled:(BOOL)loading;

- (void)registerTableView:(UITableView *)tableView
     cellIdentifiers:(NSArray *)identifiers
    addPullToRefresh:(BOOL)value
  pageLoadingEnabled:(BOOL)loading;

- (void)reloadData;
- (void)deleteRow:(RTAdapterItem *)item;
- (void)selectRow:(RTAdapterItem *)item;
- (void)selectRowPosition:(int)position;
- (void)insertRow:(int)position;
- (void)scrollToRowAtPosition:(int)position atScrollPosition:(UITableViewScrollPosition)scroll animated:(BOOL)anim;
- (void)scrollToRowAtItem:(RTAdapterItem *)item atScrollPosition:(UITableViewScrollPosition)scroll animated:(BOOL)anim;

@end


