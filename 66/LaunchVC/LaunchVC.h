//
//  LaunchVC.h
//  rwd
//
//  Created by 易健军 on 15/4/27.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LaunchVC : BaseViewController {
    __weak IBOutlet UIWebView *_webView;
}

@property (nonatomic,copy) void (^didFinishLoad)();

@end
