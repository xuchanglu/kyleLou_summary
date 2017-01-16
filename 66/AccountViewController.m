//
//  AccountViewController.m
//  66
//
//  Created by Yasin-iOSer on 17/1/10.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//

#define NavigationBarHeight 44
#define TabBarHeight 49

#import "AccountViewController.h"
#import "LL_MyCenterCollectionCell.h"
#import "LL_MyCenterHeadView.h"


#define KMyCellIdentify       @"LL_MyCenterCollectionCell"
#define KMyHeadViewIdentify   @"LL_MyCollectionHeadView"

@interface AccountViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton  *myLogoutBtn;
@property(nonatomic,strong)UICollectionView  *myCollectionView;

//是否签到
@property(nonatomic,assign)BOOL isPunch;
@property(nonatomic,strong)UILabel * integralLabel;
@property(nonatomic,strong)UIButton * myRighddtBtn;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initView {
    [self initTablePlainView:CGRectMake(0, 0, self.screenWidth, self.screenHeight - NavigationBarHeight-TabBarHeight) withSeparatoStyle:UITableViewCellSeparatorStyleSingleLine];
    [self initCollectionView];
    self.myTableView.tableFooterView= [[UIView alloc]init];
    self.myTableView.tableHeaderView = self.myCollectionView;
    
}

-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing=1;
    
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, self.screenWidth, self.screenHeight - NavigationBarHeight - 20) collectionViewLayout:flowLayout];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    //    [self.baseView addSubview:self.myCollectionView];
    [self.myCollectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.myCollectionView registerClass:NSClassFromString(@"LL_MyCenterCollectionCell") forCellWithReuseIdentifier:KMyCellIdentify];
    [self.myCollectionView registerClass:NSClassFromString(@"LL_MyCenterHeadView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KMyHeadViewIdentify];
}

#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LL_MyCenterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMyCellIdentify forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
              [cell updateMyCell:@"每日签到" andWithImageName:@"myCenter_signIn"];
        }
            break;
        case 1:
        {
            [cell updateMyCell:@"我的消息" andWithImageName:@"myCenter_myMessage"];
        }
            break;
        case 2:
        {
            [cell updateMyCell:@"我的收藏" andWithImageName:@"myCenter_myFavorite"];
        }
            break;
        case 3:
        {
            [cell updateMyCell:@"我的订单" andWithImageName:@"myCenter_myOrder"];
        }
            break;
        case 4:
        {
            [cell updateMyCell:@"询价车型" andWithImageName:@"myCenter_myEnquiry"];
        }
            break;
            
        case 5:
        {
            [cell updateMyCell:@"我的积分" andWithImageName:@"myCenter_myIntegral"];
        }
            break;
        case 6:
        {
            [cell updateMyCell:@"浏览车型" andWithImageName:@"myCenter_glanceCar"];
        }
            break;
        case 7:
        {
            [cell updateMyCell:@"我的试驾" andWithImageName:@"myCenter_applyForDriveCar"];
        }
            break;
        case 8:
        {
            [cell updateMyCell:@"设置" andWithImageName:@"myCenter_Config"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
             NSLog(@"每日签到");
        }
            break;
        case 1:
        {
            NSLog(@"我的消息");
        }
            break;
        case 2:
        {
            NSLog(@"我的收藏");
        }
            break;
        case 3:
        {
            NSLog(@"我的订单");
        }
            break;
        case 4:
        {
            NSLog(@"询价车型");
        }
            break;
        case 5:
        {
            NSLog(@"我的积分");

        }
            break;
        case 6:
        {
            NSLog(@"浏览车型");
        }
            break;
        case 7:
        {
            NSLog(@"我的试驾车型");
            
        }
            break;
        case 8:
        {
            NSLog(@"设置");
        }
            break;
        default:
            break;
    }
}

- ( UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LL_MyCenterHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:KMyHeadViewIdentify forIndexPath:indexPath];
    return headView;
}

#pragma mark UICollectionViewFlowLayout delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width-3)/3, 83);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSInteger tempHeight = 160;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        tempHeight = 160*2;
    }
    return CGSizeMake(collectionView.frame.size.width, tempHeight);
}

@end


