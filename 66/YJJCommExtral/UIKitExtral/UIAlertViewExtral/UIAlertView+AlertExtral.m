//
//  UIAlertView+AlertExtral.m
//  ExtralManager
//
//  Created by YiJianjun on 14/11/6.
//  Copyright (c) 2014年 YiJianjun. All rights reserved.
//

#import "UIAlertView+AlertExtral.h"
#import <objc/runtime.h>

@implementation UIAlertView (AlertExtral)

static const char *__alertViewAssociatedObjctKey = "__alertViewAssociatedObjctKey";

- (void)showWithButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion{
    if(!completion){
        return;
    }
    
    objc_setAssociatedObject(self, __alertViewAssociatedObjctKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate = self;
    [self show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    va_list argList;
    va_start(argList, otherButtonTitles);
    
    [self alertWithTitle:title message:message clickedCompletion:completion cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles argList:argList];
    
    va_end(argList);
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles argList:(va_list)argList{
    if(8.0 <= [[[UIDevice currentDevice] systemVersion] floatValue]){
        /// iOS 8以上使用UIAlertController,button添加顺序和UIAlertView一致:cancelButton -> otherButton
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        /// cancelButton
        [alertVC addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if(completion){
                completion([alertVC.actions indexOfObject:action]);
            }
        }]];
        /// otherButton
        if(otherButtonTitles && [otherButtonTitles length]){
            [alertVC addAction:[UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(completion){
                    completion([alertVC.actions indexOfObject:action]);
                }
            }]];
            
            NSString *arg = nil;
            while((arg = va_arg(argList, NSString *))){
                if([arg isKindOfClass:[NSString class]] && [arg length]){
                    UIAlertAction *addAction = [UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        if(completion){
                            completion([alertVC.actions indexOfObject:action]);
                        }
                    }];
                    [alertVC addAction:addAction];
                }
            }
        }
        UIViewController *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
        [vc presentViewController:alertVC animated:YES completion:nil];
    }else{
        /// iOS 8以下使用UIAlertView
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
        if(otherButtonTitles && [otherButtonTitles length]){
            NSString *arg = nil;
            while((arg = va_arg(argList, NSString *))){
                if([arg isKindOfClass:[NSString class]] && [arg length]){
                    [alertView addButtonWithTitle:arg];
                }
            }
        }
        if(completion){
            [alertView showWithButtonClickedCompletion:completion];
        }else{
            [alertView show];
        }
    }
}

+ (void)alertWithTitle:(NSString *)title clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    va_list argList;
    va_start(argList, otherButtonTitles);
    
    [self alertWithTitle:title message:nil clickedCompletion:completion cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles argList:argList];
    
    va_end(argList);
}

+ (void)alertWithMessage:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    va_list argList;
    va_start(argList, otherButtonTitles);
    
    [self alertWithTitle:nil message:message clickedCompletion:completion cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles argList:argList];
    
    va_end(argList);
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle{
    [self alertWithTitle:title message:message clickedCompletion:completion cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
}

+ (void)alertWithTitle:(NSString *)title clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle{
    [self alertWithTitle:title message:nil clickedCompletion:completion cancelButtonTitle:cancelButtonTitle];
}

+ (void)alertWithMessage:(NSString *)message clickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle{
    [self alertWithTitle:nil message:message clickedCompletion:completion cancelButtonTitle:cancelButtonTitle];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle{
    [self alertWithTitle:title message:message clickedCompletion:nil cancelButtonTitle:cancelButtonTitle];
}

+ (void)alertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle{
    [self alertWithTitle:title message:nil clickedCompletion:nil cancelButtonTitle:cancelButtonTitle];
}

+ (void)alertWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle{
    [self alertWithTitle:nil message:message clickedCompletion:nil cancelButtonTitle:cancelButtonTitle];
}

#pragma mark - ---UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^completion)(NSInteger buttonIndex) = objc_getAssociatedObject(self, __alertViewAssociatedObjctKey);
    if(completion){
        completion(buttonIndex);
    }
}

@end
