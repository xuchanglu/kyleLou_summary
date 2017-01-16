//
//  DLTableViewController.m
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "DLTableViewController.h"

@interface DLTableViewController ()

@end

@implementation DLTableViewController

DEF_MODEL(myTableView);
DEF_MODEL(myDataArray);

-(id)init {
    self = [super init];
    if (self) {
        self.myDataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initTablePlainView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style
{
    self.myTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [self.myTableView setBackgroundView:nil];
    self.myTableView.separatorStyle = style;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.baseView addSubview:self.myTableView];
    
    self.myTableView.tableFooterView= [[UIView alloc]init];
}

-(void)initTableGroupView:(CGRect)rect withSeparatoStyle:(UITableViewCellSeparatorStyle)style
{
    self.myTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    [self.myTableView setBackgroundView:nil];
    self.myTableView.separatorStyle = style;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.baseView addSubview:self.myTableView];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 30)];
    
    return tempView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
