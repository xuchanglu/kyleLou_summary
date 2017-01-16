//
//  YSNavVC.m
//  rwd
//
//  Created by Yasin-iOSer on 15/9/7.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "YSNavVC.h"

@interface YSNavInsideVC : NSObject
@end

@implementation YSNavInsideVC
/// 避免消息传递失败而转发
- (void)handleNavigationTransition:(id)sender{}

@end

@interface YSNavVC ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation YSNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

/// 快速消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    YSNavInsideVC *navInsideVC = [YSNavInsideVC new];
    if ([navInsideVC forwardingTargetForSelector:aSelector]) {
        return navInsideVC;
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - --- Gesture Delegate
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (1 == self.childViewControllers.count) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }else{
        BOOL shouldRec = YES;
        
        UIViewController *vc = self.topViewController;
        SEL selector = NSSelectorFromString(@"recognizerBackEnable");
        if([vc respondsToSelector:selector]){
            shouldRec = [vc performSelector:selector];
        }
        
        /// 不识别
        if(!shouldRec){
            return NO;
        }
        
        CGPoint v = [gestureRecognizer velocityInView:gestureRecognizer.view];
        if(0 >= v.x){
            return NO;
        }
    }
    return YES;
}

#pragma mark - --- Show Actions

- (void)showOp:(BOOL)bShow animated:(BOOL)animated{
    if(_showOp){
        _showOp(bShow);
    }
}

- (void)showOpDone:(NSNumber *)bShow{
    if (_showOp) {
        _showOp([bShow boolValue]);
    }
}

#pragma mark - --- Override

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count > 0) {
        // 非根控制器才需要设置返回按钮
        // 设置返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:animated];
//    [self showOp:NO animated:animated];
}

- (void)back {
    [self popSelf];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{ // Returns the popped controller.
//    if([self.viewControllers count] <= 2){
//        [self showOp:YES animated:animated];
//    }
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{ // Pops view controllers until the one specified is on top. Returns the popped controllers.
//    NSInteger idxOfVC = [self.viewControllers indexOfObject:viewController];
//    if(idxOfVC <= 0){
//        [self showOp:YES animated:animated];
//    }
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{ // Pops until there's only a single view controller left on the stack. Returns the popped controllers.
//    [self showOp:YES animated:animated];
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - --- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger idxOfVC =[navigationController.viewControllers indexOfObject:viewController];
    NSLog(@"idx ==> %d, top idx ==> %d",idxOfVC,[navigationController.viewControllers indexOfObject:navigationController.topViewController]);
//    [self showOp:!idxOfVC animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger idxOfVC =[navigationController.viewControllers indexOfObject:viewController];
    NSLog(@"idx ==> %d, top idx ==> %d",idxOfVC,[navigationController.viewControllers indexOfObject:navigationController.topViewController]);
//    [self showOp:!idxOfVC animated:animated];
}

@end
