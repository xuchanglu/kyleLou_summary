//
//  ALAsset+PropertyExtral.m
//  rwd
//
//  Created by 易健军 on 15/3/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "ALAsset+PropertyExtral.h"

@implementation ALAsset (PropertyExtral)

// An NSString that encodes the type of asset. One of ALAssetTypePhoto, ALAssetTypeVideo or ALAssetTypeUnknown.
- (NSString *)assetType{
    return [self valueForProperty:ALAssetPropertyType];
}

// CLLocation object with the location information of the asset. Only available if location services are enabled for the caller.
- (CLLocation *)assetLocation{
    return [self valueForProperty:ALAssetPropertyLocation];
}

// Play time duration of a video asset expressed as a double wrapped in an NSNumber. For photos, kALErrorInvalidProperty is returned.
- (NSNumber *)assetDuration{
    return [self valueForProperty:ALAssetPropertyDuration];
}

// NSNumber containing an asset's orientation as defined by ALAssetOrientation.
- (ALAssetOrientation)assetOrientation{
    return (ALAssetOrientation)[[self valueForProperty:ALAssetPropertyOrientation] integerValue];
}

// An NSDate with the asset's creation date.
- (NSDate *)assetDate{
    return [self valueForProperty:ALAssetPropertyDate];
}

// Array with all the representations available for a given asset (e.g. RAW, JPEG). It is expressed as UTIs.
- (NSArray *)assetRepresentations{
    return [self valueForProperty:ALAssetPropertyRepresentations];
}

// Dictionary that maps asset representation UTIs to URLs that uniquely identify the asset.
- (NSDictionary *)assetURLs{
    return [self valueForProperty:ALAssetPropertyURLs];
}

// An NSURL that uniquely identifies the asset
- (NSURL *)assetURL{
    return [self valueForProperty:ALAssetPropertyAssetURL];
}


@end
