//
//  LLTextFeild.h
//  rwd
//
//  Created by lyc on 15/3/25.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 定制 输入框
 * 默认只带,inputAccessoryView用户回收键盘
 **/
@interface YSTextFeild : UITextField

@property (nonatomic,strong,readonly) UIButton *commitBtn;

///是否为选择
@property (nonatomic,assign) BOOL isSelectType;

/// 添加到inputAccessoryView
- (void)setCommitText:(NSString *)commitTxt completion:(void (^)(NSString *inputTxt))completion;

/// 添加右视图
- (void)setRightViewWithTips:(NSString *)tips;
/// 添加右视图
- (void)setRightImageView;

@end
