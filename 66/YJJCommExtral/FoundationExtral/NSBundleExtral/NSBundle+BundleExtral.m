//
//  NSBundle+BundleExtral.m
//  rwd
//
//  Created by YiJianJun on 15/10/14.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "NSBundle+BundleExtral.h"

#import <UIKit/UIKit.h>

@implementation NSBundle (BundleExtral)

+ (id)loadMainBunldeNibWithViewClass:(Class)viewClass{
    if(!viewClass){
        return nil;
    }
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(viewClass) owner:nil options:nil] firstObject];
}

@end
