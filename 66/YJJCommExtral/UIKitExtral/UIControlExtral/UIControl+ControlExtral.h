//
//  UIControl+ControlExtral.h
//  BPC_ECRCOC
//
//  Created by YiJianjun on 14/12/1.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * target-action 转 block
 **/
@interface UIControl (ControlExtral)

/**
 * 添加消息,快速添加一个消息,可以和现在其他的事件兼容
 * @see addTarget:action:forControlEvents: ; addControlEvents:performAction:overrideAllEvents:
 **/
- (void)addSingleControlEvents:(UIControlEvents)controlEvents performAction:(void (^)(id sender,UIControlEvents controlEvents))action;

/**
 * 添加消息,可以添加多次,可以和现在其他的事件兼容
 * @see addTarget:action:forControlEvents: ; addControlEvents:performAction:overrideAllEvents:
 **/
- (void)addControlEvents:(UIControlEvents)controlEvents performAction:(void (^)(id sender,UIControlEvents controlEvents))action;


/**
 * 添加消息,可以添加多次,重写现在其他的事件
 * @see addTarget:action:forControlEvents:
 **/
- (void)addControlEvents:(UIControlEvents)controlEvents performAction:(void (^)(id sender,UIControlEvents controlEvents))action overrideAllEvents:(BOOL)override;

@end

NS_ASSUME_NONNULL_END
