//
//  NSMutableString+StringExtral.h
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (StringExtral)
- (void)safeAppendString:(NSString *)aString;
@end

NS_ASSUME_NONNULL_END
