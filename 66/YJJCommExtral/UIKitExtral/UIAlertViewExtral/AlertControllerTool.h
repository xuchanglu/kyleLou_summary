//
//  AlertControllerTool.h
//  66
//
//  Created by Yasin-iOSer on 17/1/10.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertControllerTool : NSObject
//没有取消按钮(确认后无跳转)
+(UIAlertController *)alertMesasge:(NSString *)message  confirmHandler:(void(^)(UIAlertAction *))confirmActionHandle viewController:(UIViewController *)vc;

//没有取消按钮(确认后有跳转)
+(UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle *)preferredStyle  confirmHandler:(void(^)(UIAlertAction *))confirmActionHandler viewController:(UIViewController *)vc;

//有取消按钮的
+(UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle *)preferredStyle  confirmHandler:(void(^)(UIAlertAction *))confirmHandler cancleHandler:(void(^)(UIAlertAction *))cancleHandler viewController:(UIViewController *)vc;

@end
