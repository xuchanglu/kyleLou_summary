//
//  UITableView+TableViewExtral.m
//  rwd
//
//  Created by Yasin-iOSer on 15/9/30.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "UITableView+TableViewExtral.h"

@implementation UITableView (TableViewExtral)

/**简化注册方法
 * @param cellClass 必须是UITableViewCell的子类
 * @param identifier 标志,不能为nil或者空串
 **/
- (void)registerNibWithCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier{
    if(![cellClass isSubclassOfClass:[UITableViewCell class]] || !identifier || ![identifier length]){
        return;
    }
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:identifier];
}

/**简化注册方法
 * @param viewClass 必须是UITableViewHeaderFooterView的子类
 * @param identifier 标志,不能为nil或者空串
 **/
- (void)registerNibWithViewClass:(Class)viewClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;{
    if(![viewClass isSubclassOfClass:[UITableViewHeaderFooterView class]] || !identifier || ![identifier length]){
        return;
    }
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(viewClass) bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
}
@end
