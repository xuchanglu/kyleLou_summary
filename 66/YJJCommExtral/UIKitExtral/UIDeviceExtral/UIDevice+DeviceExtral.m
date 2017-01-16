//
//  UIDevice+DeviceExtral.m
//  rwd
//
//  Created by YiJianJun on 16/3/1.
//  Copyright © 2016年 yasin. All rights reserved.
//

#import "UIDevice+DeviceExtral.h"


@implementation UIDevice (DeviceExtral)

#pragma mark - --- Device Screen Size

- (CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

- (BOOL)is3_5Inc{
    return (self.sizeOf3_5Inc.height == self.screenHeight);
}

- (BOOL)is4_0Inc{
    return (self.sizeOf4_0Inc.height == self.screenHeight);
}

- (BOOL)is4_7Inc{
    return (self.sizeOf4_7Inc.height == self.screenHeight);
}

- (BOOL)is5_5Inc{
    return (self.sizeOf5_5Inc.height == self.screenHeight);
}

- (CGSize)sizeOf3_5Inc{
    return CGSizeMake(320.0f, 480.0f);
}

- (CGSize)sizeOf4_0Inc{
    return CGSizeMake(320.0f, 568.0f);
}

- (CGSize)sizeOf4_7Inc{
    return CGSizeMake(375.0f, 667.0f);
}

- (CGSize)sizeOf5_5Inc{
    return CGSizeMake(414.0f, 736.0f);
}

#pragma mark - --- iOS version

- (CGFloat)iOSVersion{
    return [self.systemVersion floatValue];
}

/// iOS 版本
+ (CGFloat)currentIOSVersion{
    return [[self currentDevice] iOSVersion];
}

+ (BOOL)isEqualIOSVersion:(CGFloat)iOSVersion{
    return ([self currentIOSVersion] == iOSVersion);
}

+ (BOOL)isNotEqualIOSVersion:(CGFloat)iOSVersion{
    return ([self currentIOSVersion] != iOSVersion);
}

+ (BOOL)isBelowIOSVersion:(CGFloat)iOSVersion{
    return ([self currentIOSVersion] < iOSVersion);
}

+ (BOOL)isNotBelowIOSVersion:(CGFloat)iOSVersion{
    return ([self currentIOSVersion] >= iOSVersion);
}

+ (BOOL)isAboveIOSVersion:(CGFloat)iOSVersion{
    return ([self currentIOSVersion] > iOSVersion);
}

+ (BOOL)isNotAboveIOSVersion:(CGFloat)iOSVersion{
    return ([self currentIOSVersion] <= iOSVersion);
}

#pragma mark - - 6 iOS version
/// 6 iOS version
+ (BOOL)isBelow6iOSVersion{
    return [self isBelowIOSVersion:6.0];
}

+ (BOOL)isNotBelow6iOSVersion{
    return [self isNotBelowIOSVersion:6.0];
}

+ (BOOL)isAbove6iOSVersion{
    return [self isAboveIOSVersion:6.0];
}

+ (BOOL)isNotAbove6iOSVersion{
    return [self isNotAboveIOSVersion:6.0];
}

#pragma mark - - 7 iOS version
/// 7 iOS version
+ (BOOL)isBelow7iOSVersion{
    return [self isBelowIOSVersion:7.0];
}

+ (BOOL)isNotBelow7iOSVersion{
    return [self isNotBelowIOSVersion:7.0];
}

+ (BOOL)isAbove7iOSVersion{
    return [self isAboveIOSVersion:7.0];
}

+ (BOOL)isNotAbove7iOSVersion{
    return [self isNotAboveIOSVersion:7.0];
}

#pragma mark - - 8 iOS version
/// 8 iOS version
+ (BOOL)isBelow8iOSVersion{
    return [self isBelowIOSVersion:8.0];
}

+ (BOOL)isNotBelow8iOSVersion{
    return [self isNotBelowIOSVersion:8.0];
}

+ (BOOL)isAbove8iOSVersion{
    return [self isAboveIOSVersion:8.0];
}

+ (BOOL)isNotAbove8iOSVersion{
    return [self isNotAboveIOSVersion:8.0];
}

#pragma mark - - 9 iOS version
/// 9 iOS version
+ (BOOL)isBelow9iOSVersion{
    return [self isBelowIOSVersion:9.0];
}

+ (BOOL)isNotBelow9iOSVersion{
    return [self isNotBelowIOSVersion:9.0];
}

+ (BOOL)isAbove9iOSVersion{
    return [self isAboveIOSVersion:9.0];
}

+ (BOOL)isNotAbove9iOSVersion{
    return [self isNotAboveIOSVersion:9.0];
}

/// 10 iOS version
+ (BOOL)isBelow10iOSVersion {
    return [self isBelowIOSVersion:10.0];
}

+ (BOOL)isNotBelow10iOSVersion{
    return [self isNotBelowIOSVersion:10.0];
}

+ (BOOL)isAbove10iOSVersion{
    return [self isAboveIOSVersion:10.0];
}

+ (BOOL)isNotAbove10iOSVersion{
    return [self isNotAboveIOSVersion:10.0];
}


@end

@implementation NSObject (DeviceExtral)

- (CGFloat)iOSVersion{
    return [UIDevice currentIOSVersion];
}


- (BOOL)is3_5Inc{
    return [[UIDevice currentDevice] is3_5Inc];
}

- (BOOL)is4_0Inc{
    return [[UIDevice currentDevice] is4_0Inc];
}

- (BOOL)is4_7Inc{
    return [[UIDevice currentDevice] is4_7Inc];
}

- (BOOL)is5_5Inc{
    return [[UIDevice currentDevice] is5_5Inc];
}

- (CGSize)sizeOf3_5Inc{
    return [[UIDevice currentDevice] sizeOf3_5Inc];
}

- (CGSize)sizeOf4_0Inc{
    return [[UIDevice currentDevice] sizeOf4_0Inc];
}

- (CGSize)sizeOf4_7Inc{
    return [[UIDevice currentDevice] sizeOf4_7Inc];
}

- (CGSize)sizeOf5_5Inc{
    return [[UIDevice currentDevice] sizeOf5_5Inc];
}


@end
