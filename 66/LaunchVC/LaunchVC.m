//
//  LaunchVC.m
//  rwd
//
//  Created by 易健军 on 15/4/27.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "LaunchVC.h"

@interface LaunchVC ()<UIWebViewDelegate>

@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /// 关闭时间响应
    _webView.userInteractionEnabled = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self loadHTML];
}

- (void)loadHTML{
    _webView.alpha = 0.0f;
    NSString *bundlePath = @"http://mg.soupingguo.com/bizhi/big/10/258/043/10258043.jpg";
    if(bundlePath){
        NSLog(@"%@",bundlePath);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:bundlePath]];
        [_webView loadRequest:request];
        [_webView setScalesPageToFit:YES];
    }
}

- (void)didFinishLoadPerform{
    if(_didFinishLoad){
        _didFinishLoad();
    }
}

#pragma mark - ---UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    [UIView animateWithDuration:0.2 animations:^{
        webView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(didFinishLoadPerform) withObject:nil afterDelay:2.0f];
    }];
//    webView.alpha = 1.0f;
//    [self performSelector:@selector(didFinishLoadPerform) withObject:nil afterDelay:2.0f];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
//    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
