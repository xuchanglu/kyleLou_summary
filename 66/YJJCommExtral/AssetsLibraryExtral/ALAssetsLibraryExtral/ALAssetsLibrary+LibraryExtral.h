//
//  ALAssetsLibrary+LibraryExtral.h
//  rwd
//
//  Created by 易健军 on 15/3/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALAssetsLibrary (LibraryExtral)

///共享的
+ (instancetype)sharedAssetsLibrary;

/// 由于ALAsset必须属于其自有的AssetsLibrary,转换归宿AssetsLibrary
+ (void)assetsForFromAssLibAssets:(NSArray <ALAsset *> *)otherAssets completion:(void (^)(NSArray <ALAsset *> *assets))completion;

@end

NS_ASSUME_NONNULL_END
