//
//  AlertControllerTool.m
//  66
//
//  Created by Yasin-iOSer on 17/1/10.
//  Copyright © 2017年 Yasin-iOSer. All rights reserved.
//

#import "AlertControllerTool.h"

@implementation AlertControllerTool
//没有取消按钮的
+(UIAlertController *)alertMesasge:(NSString *)message  confirmHandler:(void(^)(UIAlertAction *))confirmActionHandle viewController:(UIViewController *)vc
{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmActionHandle];
    
    [alertController addAction:confirmAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
    
}

//没有取消按钮(确认后有跳转)
+(UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle *)preferredStyle  confirmHandler:(void(^)(UIAlertAction *))confirmActionHandler viewController:(UIViewController *)vc
{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:*preferredStyle];
    
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmActionHandler];
    
    [alertController addAction:confirmAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
    
}


//有取消按钮的
+(UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle *)preferredStyle  confirmHandler:(void(^)(UIAlertAction *))confirmHandler cancleHandler:(void(^)(UIAlertAction *))cancleHandler viewController:(UIViewController *)vc
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:*preferredStyle];
    
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmHandler];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancleHandler];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancleAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
    
}

@end
