//
//  YSHelpCenterDetailVC.h
//  rwd
//
//  Created by Yasin-iOSer on 15/9/22.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "BaseViewController.h"

@class CellItemModel;
@interface YSHelpCenterDetailVC : BaseViewController{
    __weak IBOutlet UITableView *_tableView;
}


@property (nonatomic,strong) CellItemModel *model;
@property (nonatomic,strong) NSString *requestUri;

@end
