//
//  NSBundle+BundleExtral.h
//  rwd
//
//  Created by YiJianJun on 15/10/14.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (BundleExtral)

/** 加载nib文件
 * @param viewClass 视图class
 **/
+ (nullable id)loadMainBunldeNibWithViewClass:(Class)viewClass;

@end

NS_ASSUME_NONNULL_END