//
//  ALAsset+ImageExtral.h
//  rwd
//
//  Created by 易健军 on 15/3/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALAsset (ImageExtral)

/// full screen image
- (nullable UIImage *)assetFullScreenImage;

/// origin full image
- (nullable UIImage *)assetFullResolutionImage;

@end

NS_ASSUME_NONNULL_END