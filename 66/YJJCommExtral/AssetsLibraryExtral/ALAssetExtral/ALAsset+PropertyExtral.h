//
//  ALAsset+PropertyExtral.h
//  rwd
//
//  Created by 易健军 on 15/3/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALAsset (PropertyExtral)

// An NSString that encodes the type of asset. One of ALAssetTypePhoto, ALAssetTypeVideo or ALAssetTypeUnknown.
- (NSString *)assetType;

// CLLocation object with the location information of the asset. Only available if location services are enabled for the caller.
- (CLLocation *)assetLocation;

// Play time duration of a video asset expressed as a double wrapped in an NSNumber. For photos, kALErrorInvalidProperty is returned.
- (NSNumber *)assetDuration;

// NSNumber containing an asset's orientation as defined by ALAssetOrientation.
- (ALAssetOrientation)assetOrientation;

// An NSDate with the asset's creation date.
- (NSDate *)assetDate;

// Array with all the representations available for a given asset (e.g. RAW, JPEG). It is expressed as UTIs.
- (NSArray *)assetRepresentations;

// Dictionary that maps asset representation UTIs to URLs that uniquely identify the asset.
- (NSDictionary *)assetURLs;

// An NSURL that uniquely identifies the asset
- (NSURL *)assetURL;


@end

NS_ASSUME_NONNULL_END
