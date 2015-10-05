# RTDataSourceAdapter
RTDataSourceAdapter is a library that simplifies work with the UITableView controls.

<img src="https://raw.githubusercontent.com/RTILab/RTDataSourceAdapter/master/images/RTDataSourceAdapter.gif">"

# Usage
##### In your Controller
```objective-c
#import <RTDataSourceAdapter.h>

@interface ViewController : UIViewController
....
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) RTDataSourceAdapter *adapter;
....
@end
```

##### Creating RTDataSourceAdapter

```objective-c
self.adapter = [[RTDataSourceAdapter alloc] init];
self.myTable.tintColor = [UIColor redColor]; // <- color for load indicator
self.adapter.pullToRefreshWidth = 320; // <- optional, width for RefreshControl container
self.adapter.deselectable = YES; // <- can deselect row. Default:NO

[self.adapter registerTableView:self.myTable 
cellIdentifiers:cellIdentifiers // <- Array of cells identifiers (NSString)
//also you can use  "cellIdentifier:(NSString *)" for one cell identifier
addPullToRefresh:YES  // <- I think clearly - add refresh control :)
pageLoadingEnabled:YES]; //<- It adds the ability to loading parts :)
```
##### Filling RTDataSourceAdapter

```objective-c
[self.adapter.content clear]; // remove all object

[self.adapter.content addItem:cellIdentifier value:YOURmodel]; 
//or
[self.adapter.content addItem:[[RTAdapterItem alloc] initWithID:cellIdentifier value:YOURmodel]];

[self.adapter reloadData]; //update state
```

##### Events processing:

```objective-c
//cell selected
[self.adapter setSelectHandler:^(RTAdapterItem *selectedObject, NSIndexPath *indexPath) {
//your code
}];
//pull to refresh action
[self.adapter setPullToRefreshHandler:^{
//your code
}];
//load new page action
[self.adapter setLoadMoreHandler:^{
//your code
}];
```

##### Creating a cell

Cells must be inherited from RTBaseAdapterTableViewCell
```objective-c
#import <RTBaseAdapterTableViewCell.h>
@interface ExampleCell : RTBaseAdapterTableViewCell
....
@end
```
and override two methods
```objective-c
@implementation MYTableViewCell
- (void)cellContent:(YOURModel *)content
{
//your code
}

+ (CGFloat)heightFromCellContent:(YOURModel *)content
{
// calculate height
return cellHeight;
}
@end
```

## Install

RTDataSourceAdapter is available through CocoaPods. To install it, simply add the following line to your Podfile:

```objective-c
pod install 'RTDataSourceAdapter'
```
In case you don’t want to use CocoaPods - just copy the folder RTDataSourceAdapter to your Xcode project.

### Maintainers
- [Morozov Ivan](https://github.com/Allui) 
- [RTILab](https://github.com/RTILab)

## License

RTDataSourceAdapter is available under the MIT license. See the LICENSE file for more info.