//
//  YSHelpCenterDetailVC.m
//  rwd
//
//  Created by Yasin-iOSer on 15/9/22.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSHelpCenterDetailVC.h"

#import "YSHelpCenterSectionView.h"

#import "NSString+NSStringExtras.h"

#import "YSHelpCenterDetailCell.h"

@interface YSHelpCenterDetailVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_listDatas;
    NSMutableArray *_sectionHeights;
    NSMutableArray *_itemHeights;
    
    NSMutableIndexSet *_openIndexSet;
}

@end

@implementation YSHelpCenterDetailVC

static NSString *YSHelpCenterDetailCellIdentifier = @"YSHelpCenterDetailCellIdentifier";
static NSString *YSHelpCenterDetailSectionIdentifier = @"YSHelpCenterDetailSectionIdentifier";

static CGFloat YSHelpCenterDetailCellWidth = 0.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initDatas];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDatas{
    _listDatas = [NSMutableArray array];
    _sectionHeights = [NSMutableArray array];
    _itemHeights = [NSMutableArray array];
    _openIndexSet = [NSMutableIndexSet indexSet];
    
    if(!YSHelpCenterDetailCellWidth){
        YSHelpCenterDetailCellWidth = self.screenWidth - 28;///20 + 8
    }
}

- (void)initUI{
    self.title = self.title?:@"帮助中心";
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YSHelpCenterDetailCell class]) bundle:nil] forCellReuseIdentifier:YSHelpCenterDetailCellIdentifier];
    [_tableView registerClass:[YSHelpCenterSectionView class] forHeaderFooterViewReuseIdentifier:YSHelpCenterDetailSectionIdentifier];
    
}

#pragma mark - ---UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([_openIndexSet containsIndex:section]){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHelpCenterDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:YSHelpCenterDetailCellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;//YSHelpCenterCellDefaultHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YSHelpCenterSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:YSHelpCenterDetailSectionIdentifier];
    sectionView.sectionTitleFontSize = 14.0f;
    [sectionView configViewsWithSize:CGSizeMake(self.screenWidth, [_sectionHeights[section] floatValue])];
    sectionView.sectionIndex = section;
    sectionView.sectionTitle = @"你好,你是谁?";
    sectionView.sectionSelected = [_openIndexSet containsIndex:section];
    
    [sectionView setDidClickOp:^(YSHelpCenterSectionView *sView) {
        NSUInteger sectionIdx = sView.sectionIndex;
        
        NSMutableIndexSet *sectionIdxSet = [_openIndexSet mutableCopy];
        [sectionIdxSet addIndex:sectionIdx];
        
        if([_openIndexSet containsIndex:sectionIdx]){
            [_openIndexSet removeIndex:sectionIdx];
        }else{
            [_openIndexSet removeAllIndexes];/// 决定多选或者单选
            [_openIndexSet addIndex:sectionIdx];
        }
        
        //        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIdx] withRowAnimation:UITableViewRowAnimationFade];///单选
        [_tableView reloadSections:sectionIdxSet withRowAnimation:UITableViewRowAnimationFade];///多选
    }];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

@end
