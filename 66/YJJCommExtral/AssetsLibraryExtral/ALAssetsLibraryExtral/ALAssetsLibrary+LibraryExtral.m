//
//  ALAssetsLibrary+LibraryExtral.m
//  rwd
//
//  Created by 易健军 on 15/3/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "ALAssetsLibrary+LibraryExtral.h"

@implementation ALAssetsLibrary (LibraryExtral)

static ALAssetsLibrary *__sharedAssetsLib;

///共享的
+ (instancetype)sharedAssetsLibrary{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedAssetsLib = [[self alloc] init];
    });
    
    return __sharedAssetsLib;
}

/// 由于ALAsset必须属于其自有的AssetsLibrary,转换归宿AssetsLibrary
+ (void)assetsForFromAssLibAssets:(NSArray <ALAsset *> *)otherAssets completion:(void (^)(NSArray <ALAsset *> *assets))completion{
    if(!otherAssets || ![otherAssets count]){
        if(completion){completion(nil);}
        return;
    }
    __weak ALAssetsLibrary *assetsLib = [self sharedAssetsLibrary];
    NSMutableArray <ALAsset *> *assets = [NSMutableArray array];
    __block BOOL stop = NO;
    for (ALAsset *asset in otherAssets) {
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        [assetsLib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            if(stop){
                if(completion){completion(nil);}
                return;
            }
            
            if(asset){
                [assets addObject:asset];
            }else{
                stop = YES;
            }
            
            /// 最后一个
            if([assets count] == [otherAssets count]){
                if(completion){completion(assets);}
            }
        } failureBlock:^(NSError *error) {
            stop = YES;
        }];
    }
}

@end
