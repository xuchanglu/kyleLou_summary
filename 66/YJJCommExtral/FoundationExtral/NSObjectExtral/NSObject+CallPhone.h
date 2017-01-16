//
//  NSObject+NSNullValue.h
//  VXiao
//
//  Created by YiJianjun on 14-2-20.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///如果实现了UIAlertViewDelegate,需要根据tag判断,在alertView:clickedButtonAtIndex:中调用callPhone_alertView:clickedButtonAtIndex:
@interface NSObject (CallPhoneCategory)<UIAlertViewDelegate>

- (void)callPhone:(NSString *)phoneNumber completion:(void (^)(BOOL success))completion;
- (void)callPhone:(NSString *)phoneNumber valid:(BOOL)vaild completion:(void (^)(BOOL success))completion;

- (void)callPhone_alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

NS_ASSUME_NONNULL_END