//
//  ALAsset+ImageExtral.m
//  rwd
//
//  Created by 易健军 on 15/3/19.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "ALAsset+ImageExtral.h"

@implementation ALAsset (ImageExtral)

/// full screen image
- (UIImage *)assetFullScreenImage{
    struct CGImage *imgRef = self.defaultRepresentation.fullScreenImage;
    
    if(imgRef){
        return [UIImage imageWithCGImage:imgRef];
    }else{
        return nil;
    }
}

/// origin full image
- (UIImage *)assetFullResolutionImage{
    struct CGImage *imgRef = self.defaultRepresentation.fullResolutionImage;
    
    if(imgRef){
        return [UIImage imageWithCGImage:imgRef];
    }else{
        return nil;
    }
}


@end
