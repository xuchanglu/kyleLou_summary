//
//  UIDevice+DeviceExtral.h
//  rwd
//
//  Created by YiJianJun on 16/3/1.
//  Copyright © 2016年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (DeviceExtral)

/// 根据屏幕高度判断
@property (nonatomic,assign,readonly) BOOL is3_5Inc;
@property (nonatomic,assign,readonly) BOOL is4_0Inc;
@property (nonatomic,assign,readonly) BOOL is4_7Inc;
@property (nonatomic,assign,readonly) BOOL is5_5Inc;

/*
 1.iPhone4(S)分辨率320x480,像素640x960 , @1x / @2x
 2.iPhone5(C/S)分辨率320x568，像素640x1136，@2x
 3.iPhone6(S)分辨率375x667，像素750x1334，@2x
 4.iPhone6(S) Plus分辨率414x736，像素1242x2208，@3x
 
 这里所注的都是已经添加相关尺寸loading图后的开发分辨率和像素数，其中iphone6 plus最终的物理分辨率会被苹果自动缩放到1080p(缩放比例1.14)。
 */
@property (nonatomic,assign,readonly) CGSize sizeOf3_5Inc;
@property (nonatomic,assign,readonly) CGSize sizeOf4_0Inc;
@property (nonatomic,assign,readonly) CGSize sizeOf4_7Inc;
@property (nonatomic,assign,readonly) CGSize sizeOf5_5Inc;

/// iOS 版本
@property (nonatomic,assign,readonly) CGFloat iOSVersion;

/// iOS 版本
+ (CGFloat)currentIOSVersion;
/// == iOSVersion
+ (BOOL)isEqualIOSVersion:(CGFloat)iOSVersion;
/// != iOSVersion
+ (BOOL)isNotEqualIOSVersion:(CGFloat)iOSVersion;
/// < iOSVersion
+ (BOOL)isBelowIOSVersion:(CGFloat)iOSVersion;
/// >= iOSVersion
+ (BOOL)isNotBelowIOSVersion:(CGFloat)iOSVersion;
/// > iOSVersion
+ (BOOL)isAboveIOSVersion:(CGFloat)iOSVersion;
/// <= iOSVersion
+ (BOOL)isNotAboveIOSVersion:(CGFloat)iOSVersion;

/// 6 iOS version
+ (BOOL)isBelow6iOSVersion;
+ (BOOL)isNotBelow6iOSVersion;
+ (BOOL)isAbove6iOSVersion;
+ (BOOL)isNotAbove6iOSVersion;

/// 7 iOS version
+ (BOOL)isBelow7iOSVersion;
+ (BOOL)isNotBelow7iOSVersion;
+ (BOOL)isAbove7iOSVersion;
+ (BOOL)isNotAbove7iOSVersion;

/// 8 iOS version
+ (BOOL)isBelow8iOSVersion;
+ (BOOL)isNotBelow8iOSVersion;
+ (BOOL)isAbove8iOSVersion;
+ (BOOL)isNotAbove8iOSVersion;

/// 9 iOS version
+ (BOOL)isBelow9iOSVersion;
+ (BOOL)isNotBelow9iOSVersion;
+ (BOOL)isAbove9iOSVersion;
+ (BOOL)isNotAbove9iOSVersion;

/// 10 iOS version
+ (BOOL)isBelow10iOSVersion;
+ (BOOL)isNotBelow10iOSVersion;
+ (BOOL)isAbove10iOSVersion;
+ (BOOL)isNotAbove10iOSVersion;

@end

@interface NSObject (DeviceExtral)

@property (nonatomic,assign,readonly) CGFloat iOSVersion;

/// 根据屏幕高度判断
@property (nonatomic,assign,readonly) BOOL is3_5Inc;
@property (nonatomic,assign,readonly) BOOL is4_0Inc;
@property (nonatomic,assign,readonly) BOOL is4_7Inc;
@property (nonatomic,assign,readonly) BOOL is5_5Inc;

/*
 1.iPhone4(S)分辨率320x480,像素640x960 , @1x / @2x
 2.iPhone5(C/S)分辨率320x568，像素640x1136，@2x
 3.iPhone6(S)分辨率375x667，像素750x1334，@2x
 4.iPhone6(S) Plus分辨率414x736，像素1242x2208，@3x
 
 这里所注的都是已经添加相关尺寸loading图后的开发分辨率和像素数，其中iphone6 plus最终的物理分辨率会被苹果自动缩放到1080p(缩放比例1.14)。
 */
@property (nonatomic,assign,readonly) CGSize sizeOf3_5Inc;
@property (nonatomic,assign,readonly) CGSize sizeOf4_0Inc;
@property (nonatomic,assign,readonly) CGSize sizeOf4_7Inc;
@property (nonatomic,assign,readonly) CGSize sizeOf5_5Inc;
@end


NS_ASSUME_NONNULL_END
