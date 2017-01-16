//
//  DLTableViewController.h
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "BaseViewController.h"

@interface DLTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

AS_MODEL_STRONG(UITableView, myTableView);
AS_MODEL_STRONG(NSMutableArray, myDataArray);

-(void)initTableGroupView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style;

-(void)initTablePlainView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style;


@end
 
