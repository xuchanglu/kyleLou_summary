//
//  NSMutableString+StringExtral.m
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import "NSMutableString+StringExtral.h"

@implementation NSMutableString (StringExtral)
- (void)safeAppendString:(NSString *)aString{
    if(aString && [aString isKindOfClass:[NSString class]] && [aString length]){
        [self appendString:aString];
    }
}
@end
