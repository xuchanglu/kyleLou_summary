//
//  CALayer+YSLayerColor.m
//  rwd
//
//  Created by Yasin-iOSer on 16/9/24.
//  Copyright © 2016年 yasin. All rights reserved.
//

#import "CALayer+YSLayerColor.h"


@implementation CALayer (YSLayerColor)

- (void)setColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end
