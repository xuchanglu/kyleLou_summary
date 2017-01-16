//
//  UIScreen+ScreenExtral.m
//  rwd
//
//  Created by YiJianJun on 16/3/1.
//  Copyright © 2016年 yasin. All rights reserved.
//

#import "UIScreen+ScreenExtral.h"

@implementation UIScreen (ScreenExtral)

#pragma mark - --- Screen Size

- (CGFloat)screenWidth{
    return self.screenSize.width;
}

- (CGFloat)screenHeight{
    return self.screenSize.height;
}

- (CGSize)screenSize{
    return self.bounds.size;
}

- (CGFloat)scaleOfPiexl{
    return self.scale;
}

+ (CGFloat)screenWidth{
    return [self mainScreen].screenWidth;
}

+ (CGFloat)screenHeight{
    return [self mainScreen].screenHeight;
}

+ (CGSize)screenSize{
    return [self mainScreen].screenSize;
}

+ (CGFloat)scaleOfPiexl{
    return [self mainScreen].scaleOfPiexl;
}

@end

@implementation NSObject (ScreenExtral)

- (CGFloat)screenWidth{
    return [UIScreen screenWidth];
}

- (CGFloat)screenHeight{
    return [UIScreen screenHeight];
}

- (CGSize)screenSize{
    return [UIScreen screenSize];
}

- (CGFloat)scaleOfPiexl{
    return [UIScreen scaleOfPiexl];
}

@end
