//
//  NSObject+NSNullValue.h
//  VXiao
//
//  Created by YiJianjun on 14-2-20.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ValueValidity)
- (BOOL)hasValue;
+ (BOOL)hasValueWithObject:(id)object;

- (BOOL)isNullValue;
+ (BOOL)isNullValueWithObject:(id)object;

- (BOOL)isVaildValue;
+ (BOOL)isVaildValueWithObject:(id)object;
@end

@interface NSObject (KindClass)
- (NSString *)nameOfClass;
+ (NSString *)nameOfClassWithObject:(id)object;
@end

@interface NSDictionary (ValueValidity)
- (BOOL)hasKey:(NSString *)key;
- (BOOL)isVaildKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END