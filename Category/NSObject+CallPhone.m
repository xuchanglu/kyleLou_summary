//
//  NSObject+NSNullValue.m
//  VXiao
//
//  Created by YiJianjun on 14-2-20.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSObject+CallPhone.h"
#import <objc/runtime.h>
#import "NSString+NSStringExtras.h"
#import "UIAlertView+AlertExtral.h"
#import "UIView+ToastShowExtral.h"

@implementation NSObject (CallPhoneCategory)

static const void *__kPhoneNumber = @"__PhoneNumberKey__";
static const void *__kCallPhoneCompletion = @"__CallPhoneCompletionKey__";

static NSInteger CallPhoneAlertViewTag = 111111;

- (void)__setPhoneNumber:(NSString *)phoneNumber{
    objc_setAssociatedObject(self, __kPhoneNumber, phoneNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)__getPhoneNumber{
    return (NSString *)objc_getAssociatedObject(self, __kPhoneNumber);
}

- (void)__setCompletion:(void (^)(BOOL success))completion{
    objc_setAssociatedObject(self, __kCallPhoneCompletion, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(BOOL success))__getCompletion{
    void (^completion)(BOOL success) = objc_getAssociatedObject(self, __kCallPhoneCompletion);
    return completion;
}

- (void)callPhone:(NSString *)phoneNumber completion:(void (^)(BOOL success))completion{
    [self callPhone:phoneNumber valid:YES completion:completion];
}

- (void)callPhone:(NSString *)phoneNumber valid:(BOOL)vaild completion:(void (^)(BOOL success))completion{
    if(vaild && ![phoneNumber isRightPhoneNumber]){
        if(completion){
            completion(NO);
        }
        return;
    }
    [self __setPhoneNumber:phoneNumber];
    if(completion){
        [self __setCompletion:completion];
    }
    NSString *msg = [NSString stringWithFormat:@"你要直接拨打电话%@吗?",phoneNumber];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    alertView.tag = CallPhoneAlertViewTag;
    
    [alertView showWithButtonClickedCompletion:^(NSInteger buttonIndex) {
        [self callPhone_alertView:alertView clickedButtonAtIndex:buttonIndex];
    }];
}

#pragma mark - ---UIAlertViewDelegate

- (void)callPhone_alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == CallPhoneAlertViewTag){
        if(buttonIndex){
            NSString *phoneNumber = [self __getPhoneNumber];
            
            NSString *urlString = [NSString stringWithFormat:@"tel://%@",phoneNumber];
            NSURL *url = [NSURL URLWithString:urlString];
            if(!url){
                return;
            }
            UIApplication *app = [UIApplication sharedApplication];
            BOOL success = NO;
            if([app canOpenURL:url]){
                success = [app openURL:url];
            }else{
                success = NO;
                [UIView showMessage:[NSString stringWithFormat:@"不能拨打电话%@",phoneNumber]];
            }
            void (^completion)(BOOL success) = [self __getCompletion];
            if(completion){
                completion(success);
            }
        }
    }
}

@end
