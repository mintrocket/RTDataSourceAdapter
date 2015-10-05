//
//  RTDatasourceAdapter.m
//  RTDatasourceAdapter
//
//  Created by Ivan Morozov on 03.10.15.
//  Copyright (c) 2015 RTILab. All rights reserved.
//

#import "RTDataSourceAdapter.h"
#import "RTBaseAdapterTableViewCell.h"
#import "UIImageView+RTAnimating.h"

@interface RTDataSourceAdapter ()
{
    RTselectHandler selectedHandler;
    RTwillDisplayCellHandler willDisplayHandler;
    RTdidEndDisplayingCellHandler endDisplayingHandler;
    RTvoidHandler refreshHandler;
    RTvoidHandler loadHandler;
    UITableView *table;
    UIView *footerView;
    UIImageView *footerActInd;
}

@property (assign, nonatomic) BOOL isPageLoading;

@end

@implementation RTDataSourceAdapter

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.content = [[RTDataSourceAdapterContent alloc] init];
        self.pullToRefreshWidth = [[UIScreen mainScreen] bounds].size.width;
    }
    
    return self;
}

- (instancetype)initWithRTAdapterItems:(NSArray *)items
{
    self = [super init];
    
    if (self) {
        self.content = [[RTDataSourceAdapterContent alloc] initWithRTAdapterItems:items];
        self.pullToRefreshWidth = [[UIScreen mainScreen] bounds].size.width;
    }
    
    return self;
}

#pragma mark - Register TableView

- (void)registerTableView:(UITableView *)tableView
      cellIdentifier:(NSString *)identifier
    addPullToRefresh:(BOOL)value
  pageLoadingEnabled:(BOOL)loading
{
    table = tableView;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.pageLoadingEnabled = loading;
    
    [self registerNibForTable:tableView cellIdentifier:identifier];
    
    if (value) [self addPullToRefreshControl];
    if (loading) [self addFooter];
}

- (void)registerTableView:(UITableView *)tableView
     cellIdentifiers:(NSArray *)identifiers
    addPullToRefresh:(BOOL)value
  pageLoadingEnabled:(BOOL)loading
{
    table = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.pageLoadingEnabled = loading;
    
    for (NSString *identifier in identifiers) {
        [self registerNibForTable:tableView cellIdentifier:identifier];
    }
    
    if (value) [self addPullToRefreshControl];
    if (loading) [self addFooter];
}

- (void)registerNibForTable:(UITableView *)tableView cellIdentifier:(NSString *)identifier
{
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}

- (void)addPullToRefreshControl
{
    refreshControl = [[RTRefreshControl alloc] init];
    [table addSubview:refreshControl];
    [refreshControl addTarget:self
                       action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    
    [refreshControl setup:self.pullToRefreshWidth color:table.tintColor];
}

- (void)addFooter
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect footerFrame = CGRectMake(0, 0, screenRect.size.width, 44);
    footerView = [[UIView alloc] initWithFrame:footerFrame];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.hidden = false;
    footerActInd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rt_loader"]];
    footerActInd.image = [footerActInd.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    footerActInd.tintColor = table.tintColor;
    footerActInd.center = CGPointMake(screenRect.size.width/2.0, 30);
    [footerView addSubview:footerActInd];
}

#pragma mark - Handlers

- (void)setPullToRefreshHandler:(RTvoidHandler)refresh
{
    refreshHandler = refresh;
}

- (void)setLoadMoreHandler:(RTvoidHandler)load
{
    loadHandler = load;
}

- (void)setSelectHandler:(RTselectHandler)selected
{
    selectedHandler = selected;
}

- (void)setWillDisplayCellHandler:(RTwillDisplayCellHandler)willDisplay
{
    willDisplayHandler = willDisplay;
}

- (void)setDidEndDisplayingCellHandler:(RTdidEndDisplayingCellHandler)endDisplaying
{
    endDisplayingHandler = endDisplaying;
}


#pragma mark - SupportMethods

- (void)reloadData
{
    [table reloadData];
    [self hideLoading];
    self.isPageLoading = NO;
}

- (void)deleteRow:(RTAdapterItem *)item
{
    [table deleteRowsAtIndexPaths:@[item.index] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)insertRow:(int)position
{
    [table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:position inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)selectRow:(RTAdapterItem *)item
{
    if (item.index)
    [table selectRowAtIndexPath:item.index animated:NO  scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)selectRowPosition:(int)position
{
    [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)scrollToRowAtPosition:(int)position atScrollPosition:(UITableViewScrollPosition)scroll animated:(BOOL)anim
{
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0]
                     atScrollPosition:scroll animated:anim];
}

- (void)scrollToRowAtItem:(RTAdapterItem *)item atScrollPosition:(UITableViewScrollPosition)scroll animated:(BOOL)anim
{
    [table scrollToRowAtIndexPath:item.index atScrollPosition:scroll animated:anim];
}

- (void)refresh
{
    if (refreshHandler) refreshHandler();
    
    [refreshControl endRefreshing];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshControl pull];
}

- (void)loadMore
{
    if (loadHandler) loadHandler();
}

- (void)showLoading
{
    footerView.hidden = NO;
    table.tableFooterView = footerView;
    [footerActInd rt_startAnimating];
}

- (void)hideLoading
{
    footerView.hidden = YES;
    table.tableFooterView = nil;
    [footerActInd rt_stopAnimating];
}

#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.content) return [self.content getCount];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTAdapterItem *item = [self.content getItem:indexPath.row];
    if (!item) return [UITableViewCell new];
    
    item.index = indexPath;
    
    RTBaseAdapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.itemID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.isFirst = YES;
    } else if ([self.content getCount] - 1 == indexPath.row){
        cell.isLast = YES;
    }
    
    if (item.isSelected) [self selectRow:item];
    
    [cell cellContent:item.itemValue];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTAdapterItem *item = [self.content getItem:indexPath.row];
    
    Class<RTCellHeight> cellClass = NSClassFromString(item.itemID);
    
    return [cellClass heightFromCellContent:item.itemValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.deselectable) [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (selectedHandler) selectedHandler([self.content getItem:indexPath.row], indexPath);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTAdapterItem *item = [self.content getItem:indexPath.row];
    
    item.isSelected = NO;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (willDisplayHandler) willDisplayHandler([self.content getItem:indexPath.row], indexPath);
    
    if (self.isPageLoading || !self.pageLoadingEnabled) {
        return;
    }
    
    if ((indexPath.row == [self.content getCount] - 1) && self.isPageLoading == false) {
        [self showLoading];
        self.isPageLoading = YES;
        
        __weak typeof(self)weakSelf = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadMore];
        });
        
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (endDisplayingHandler) endDisplayingHandler([self.content getItem:indexPath.row], indexPath);
}


@end
