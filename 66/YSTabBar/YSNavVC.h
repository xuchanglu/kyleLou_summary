//
//  YSNavVC.h
//  rwd
//
//  Created by Yasin-iOSer on 15/9/7.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSNavVC : UINavigationController

/// 隐藏 tabbarVC中tabBar时的调用
@property (nonatomic,copy) void (^showOp)(BOOL show);

@end
