//
//  NSObject+NSNullValue.m
//  VXiao
//
//  Created by YiJianjun on 14-2-20.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSObject+ObjectExtral.h"

@implementation NSObject (NSTimerExtral)

+ (void)removeTimer:(NSTimer *)timer{
    if([timer isKindOfClass:[NSTimer class]]){
        if(timer){
            if([timer isValid]){
                [timer invalidate];
            }
            timer = nil;
        }
    }else{
        timer = nil;
    }
}

@end
