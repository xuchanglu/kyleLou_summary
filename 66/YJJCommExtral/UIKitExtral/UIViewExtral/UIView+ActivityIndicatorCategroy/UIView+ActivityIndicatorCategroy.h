//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __UIView_Extral__
    #define __UIView_Extral__
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ActivityIndicatorCategroy)
- (void)showWhiteLargeActivityIndicator;
- (void)showWhiteActivityIndicator;
- (void)showGrayActivityIndicator;
/**show
 *@param style UIActivityIndicatorViewStyleWhiteLarge,UIActivityIndicatorViewStyleWhite,UIActivityIndicatorViewStyleGray,
 **/
- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style;
- (void)hideActivityIndicator;

@end

NS_ASSUME_NONNULL_END
