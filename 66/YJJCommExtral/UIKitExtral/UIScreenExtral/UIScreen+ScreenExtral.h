//
//  UIScreen+ScreenExtral.h
//  rwd
//
//  Created by YiJianJun on 16/3/1.
//  Copyright © 2016年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (ScreenExtral)
/// Screen Size
@property (nonatomic,assign,readonly) CGFloat screenWidth;
@property (nonatomic,assign,readonly) CGFloat screenHeight;
@property (nonatomic,assign,readonly) CGSize screenSize;

/// scale
@property (nonatomic,assign,readonly) CGFloat scaleOfPiexl;

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGSize)screenSize;

+ (CGFloat)scaleOfPiexl;

@end

@interface NSObject (ScreenExtral)
/// Screen Size
@property (nonatomic,assign,readonly) CGFloat screenWidth;
@property (nonatomic,assign,readonly) CGFloat screenHeight;
@property (nonatomic,assign,readonly) CGSize screenSize;

/// scale
@property (nonatomic,assign,readonly) CGFloat scaleOfPiexl;

@end

NS_ASSUME_NONNULL_END
