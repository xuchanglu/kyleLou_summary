//
//  CGRectHelper.h
//  VXiao
//
//  Created by YiJianjun on 14-2-13.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGRectHelper : NSObject
+ (CGRect)rectChange:(CGRect)rect withDx:(CGFloat)dx;
+ (CGRect)rectChange:(CGRect)rect withDy:(CGFloat)dy;
+ (CGRect)rectChange:(CGRect)rect withDWidth:(CGFloat)dWidth;
+ (CGRect)rectChange:(CGRect)rect withDHeight:(CGFloat)dHeight;
+ (CGRect)rectChange:(CGRect)rect withDx:(CGFloat)dx dWidth:(CGFloat)dWidth;
+ (CGRect)rectChange:(CGRect)rect withDy:(CGFloat)dy dHeight:(CGFloat)dHeight;

+ (CGRect)rectChange:(CGRect)rect withDxAndDWidth:(CGFloat)dValue;
+ (CGRect)rectChange:(CGRect)rect withDyAndDHeight:(CGFloat)dValue;

+ (CGRect)rectChange:(CGRect)rect withX:(CGFloat)x;
+ (CGRect)rectChange:(CGRect)rect withY:(CGFloat)y;
+ (CGRect)rectChange:(CGRect)rect withWidth:(CGFloat)width;
+ (CGRect)rectChange:(CGRect)rect withHeight:(CGFloat)height;
+ (CGRect)rectChange:(CGRect)rect withX:(CGFloat)x width:(CGFloat)width;
+ (CGRect)rectChange:(CGRect)rect withY:(CGFloat)y height:(CGFloat)height;

+ (CGRect)rectChange:(CGRect)rect withPoint:(CGPoint)point;
+ (CGRect)rectChange:(CGRect)rect withSize:(CGSize)size;
+ (CGRect)rectWithPoint:(CGPoint)point size:(CGSize)size;

+ (CGRect)rectChange:(CGRect)rect withCenterPoint:(CGPoint)point;

+ (CGRect)rectChange:(CGRect)rect withDx:(CGFloat)dx dy:(CGFloat)dy dWidth:(CGFloat)dWidth dHeight:(CGFloat)dHeight;

+ (CGRect)rectWithFitSize:(CGSize)fitSize maxSize:(CGSize)size;

+ (CGRect)rectChange:(CGRect)rect withTop:(CGFloat)top;
+ (CGRect)rectChange:(CGRect)rect withLeft:(CGFloat)left;
+ (CGRect)rectChange:(CGRect)rect withBottom:(CGFloat)bottom;
+ (CGRect)rectChange:(CGRect)rect withRight:(CGFloat)right;


@end

NS_ASSUME_NONNULL_END
