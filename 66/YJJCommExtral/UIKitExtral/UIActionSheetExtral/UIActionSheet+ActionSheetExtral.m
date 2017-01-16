//
//  UIActionSeet+ActionSeetExtral.m
//  ExtralManager
//
//  Created by YiJianjun on 14/11/6.
//  Copyright (c) 2014年 YiJianjun. All rights reserved.
//

#import "UIActionSheet+ActionSheetExtral.h"
#import <objc/runtime.h>

@implementation UIActionSheet (ActionSeetExtral)

static const char *__actionSheetViewAssociatedObjctKey = "__actionSheetAssociatedObjctKey";

- (void)showInView:(__weak UIView *)view withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion{
    if(!completion){
        return;
    }
    
    objc_setAssociatedObject(self, __actionSheetViewAssociatedObjctKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate = (id<UIActionSheetDelegate>)self;
    [self showInView:view];
}

+ (void)sheetWithTitle:(NSString *)title inView:(nullable __weak UIView *)view withButtonClickedCompletion:(nullable void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles vaList:(va_list)vaList{
    if(8.0 <= [[[UIDevice currentDevice] systemVersion] floatValue]){
        /// iOS 8以上使用UIAlertController
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        /// 添加顺序与UIActionSheet一致,destructiveButton -> otherButtons -> cancelButton
        /// destructiveButton
        if(destructiveButtonTitle && [destructiveButtonTitle length]){
            [alertVC addAction:[UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                if(completion){
                    completion([alertVC.actions indexOfObject:action]);
                }
            }]];
        }
        
        /// otherButton
        if(otherButtonTitles && [otherButtonTitles length]){
            [alertVC addAction:[UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(completion){
                    completion([alertVC.actions indexOfObject:action]);
                }
            }]];
            
            NSString *title = nil;
            while ((title = va_arg(vaList, NSString *))) {
                if([title isKindOfClass:[NSString class]] && [title length]){
                    [alertVC addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if(completion){
                            completion([alertVC.actions indexOfObject:action]);
                        }
                    }]];
                }
            }
        }
        
        /// cancelButton
        if(cancelButtonTitle && [cancelButtonTitle length]){
            [alertVC addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if(completion){
                    completion([alertVC.actions indexOfObject:action]);
                }
            }]];
        }
        UIViewController *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
        [vc presentViewController:alertVC animated:YES completion:nil];
    }else{
        /// iOS 8以下使用UIActionSheet
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
        
        if(otherButtonTitles && [otherButtonTitles length]){
            NSString *title = nil;
            while ((title = va_arg(vaList, NSString *))) {
                if([title isKindOfClass:[NSString class]] && [title length]){
                    [actionSheet addButtonWithTitle:title];
                }
            }
        }
        if(!view){
            view = [[UIApplication sharedApplication].delegate window];
        }
        if(completion){
            [actionSheet showInView:view withButtonClickedCompletion:completion];
        }else{
            [actionSheet showInView:view];
        }
    }
}

+ (void)sheetWithTitle:(NSString *)title inView:(__weak UIView *)view withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    va_list vaList;
    va_start(vaList, otherButtonTitles);
    
    [self sheetWithTitle:title inView:view withButtonClickedCompletion:completion cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles vaList:vaList];
    
    va_end(vaList);
}

+ (void)sheetWithTitle:(NSString *)title withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    va_list vaList;
    va_start(vaList, otherButtonTitles);
    
    [self sheetWithTitle:title inView:nil withButtonClickedCompletion:completion cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles vaList:vaList];
    
    va_end(vaList);
}

+ (void)sheetWithTitle:(NSString *)title withButtonClickedCompletion:(void (^)(NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle{
    [self sheetWithTitle:title inView:nil withButtonClickedCompletion:completion cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
}

#pragma mark - ---UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;{
    void (^completion)(NSInteger buttonIndex) = objc_getAssociatedObject(self, __actionSheetViewAssociatedObjctKey);
    if(completion){
        completion(buttonIndex);
    }
}

@end
