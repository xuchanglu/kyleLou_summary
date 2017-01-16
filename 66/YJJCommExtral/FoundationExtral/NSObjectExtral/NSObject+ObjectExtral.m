//
//  NSObject+NSNullValue.m
//  VXiao
//
//  Created by YiJianjun on 14-2-20.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSObject+ObjectExtral.h"

@implementation NSObject (ValueValidity)

- (BOOL)hasValue{
    return ![self isNullValue];
}

+ (BOOL)hasValueWithObject:(id)object{
    return ![self isNullValueWithObject:object];
}

- (BOOL)isNullValue{
    if(self && [self isKindOfClass:[NSNull class]]){
        return YES;
    }
    return NO;
}

+ (BOOL)isNullValueWithObject:(id)object{
    return !object || [object isNullValue];
}

- (BOOL)isVaildValue{
    if([self isKindOfClass:[self class]] && [self hasValue]){
        return YES;
    }
    return NO;
}

+ (BOOL)isVaildValueWithObject:(id)object{
    return [object isVaildValue];
}

@end

@implementation NSObject (KindClass)

- (NSString *)nameOfClass{
    return NSStringFromClass([self class]);
}

+ (NSString *)nameOfClassWithObject:(id)object{
    return [object nameOfClass];
}

@end

@implementation NSDictionary (ValueValidity)

- (BOOL)hasKey:(NSString *)key{
    if([key isVaildValue]){
        id value = [self objectForKey:key];
        return value?YES:NO;
    }
    return NO;
}

- (BOOL)isVaildKey:(NSString *)key{
    if([key isVaildValue]){
        id value = [self objectForKey:key];
        return [value isVaildValue];
    }
    return NO;
}

@end
