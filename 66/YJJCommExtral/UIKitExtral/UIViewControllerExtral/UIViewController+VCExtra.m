//
//  UIViewController+PushExtra.m
//  VXiao
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "UIViewController+VCExtra.h"
#import <objc/runtime.h>
#import "UIView+FrameExtral.h"
#import "UIDevice+DeviceExtral.h"

@implementation UIViewController (PushExtra)


- (void)navigationPushViewController:(Class)vcClass{
    [UIViewController navigationViewController:self pushViewController:vcClass];
}

- (void)navigationPushViewController:(Class)vcClass animation:(BOOL)animation{
    [UIViewController navigationViewController:self pushViewController:vcClass animation:animation withOperation:nil];
}

- (void)navigationPushViewController:(Class)vcClass withOperation:(void (^)(id vcInstance))operation{
    [UIViewController navigationViewController:self pushViewController:vcClass animation:YES withOperation:operation];
}

- (void)navigationPushViewController:(Class)vcClass animation:(BOOL)animation withOperation:(void (^)(id vcInstance))operation{
    [UIViewController navigationViewController:self pushViewController:vcClass animation:animation withOperation:operation];
}

+ (void)navigationViewController:(UIViewController *)vc pushViewController:(Class)vcClass{
    [UIViewController navigationViewController:vc pushViewController:vcClass animation:YES withOperation:nil];
}

+ (void)navigationViewController:(UIViewController *)vc pushViewController:(Class)vcClass animation:(BOOL)animation withOperation:(void (^)(id vcInstance))operation{
    if([vcClass isSubclassOfClass:[UIViewController class]]){
        if(vc.navigationController){
            __block id pushViewController = [[vcClass alloc] init];
            [pushViewController setHidesBottomBarWhenPushed:YES];
            if(operation){
                operation(pushViewController);
            }
            [vc.navigationController pushViewController:pushViewController animated:animation];
        }else{
            NSLog(@"%@ navigation controller is nil",vc.navigationController);
        }
    }else{
        NSLog(@"%@ object is not a kind of UIViewController",vc);
    }
}

@end


@implementation UIViewController (PopExtral)

- (UIViewController *)popSelf{
    return [self popSelfWithAnimation:YES];
}

- (NSArray *)popToRootViewController{
    return [self popSelfToRootViewControllerWithAnimation:YES];
}

- (UIViewController *)poptoViewControllerWithIndex:(NSUInteger)index{
    return [self poptoViewControllerWithIndex:index animation:YES];
}

- (UIViewController *)popSelfWithAnimation:(BOOL)animation{
    if([self isKindOfClass:[UINavigationController class]]){
        return [(UINavigationController *)self popViewControllerAnimated:animation];
    }else{
        return [self.navigationController popViewControllerAnimated:animation];
    }
}

- (NSArray *)popSelfToRootViewControllerWithAnimation:(BOOL)animation{
    if([self isKindOfClass:[UINavigationController class]]){
        return [(UINavigationController *)self popToRootViewControllerAnimated:animation];
    }else{
        return [self.navigationController popToRootViewControllerAnimated:animation];
    }
}

- (UIViewController *)poptoViewControllerWithIndex:(NSUInteger)index animation:(BOOL)animation{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if(index < viewControllers.count){
        UIViewController *popVC = viewControllers[index];
        
        if([self isKindOfClass:[UINavigationController class]]){
            [(UINavigationController *)self popToViewController:popVC animated:animation];
        }else{
            [self.navigationController popToViewController:popVC animated:animation];
        }
        
        return popVC;
    }
    return nil;
}

@end

@implementation UIViewController (PresentExtral)
- (void)presentViewController:(Class)vcClass{
    [self presentViewController:vcClass animation:YES];
}

- (void)presentViewController:(Class)vcClass withOperation:(void (^)(id presentedVC))operation{
    [self presentViewController:vcClass animation:YES withOperation:operation];
}

- (void)presentViewController:(Class)vcClass animation:(BOOL)animation{
    [self presentViewController:vcClass animation:animation withOperation:nil];
}

- (void)presentViewController:(Class)vcClass animation:(BOOL)animation withOperation:(void(^)(id presentedVC))operation{
    if([vcClass isSubclassOfClass:[UIViewController class]]){
        __block id presentedVC = [[vcClass alloc] init];
        if(operation){
            operation(presentedVC);
        }
        [self presentViewController:presentedVC animated:animation completion:nil];
    }else{
        NSLog(@"%@ class is not a subclass of UIViewController",NSStringFromClass(vcClass));
    }
}

@end

@implementation UIViewController (AppExtral)

+ (id<UIApplicationDelegate> )appDelegate{
    return [[UIApplication sharedApplication] delegate];
}

+ (UIWindow *)appWindow{
    return [[self appDelegate] window];
}

+ (UIViewController *)appRootViewController{
    return [[self appWindow] rootViewController];
}

+ (UINavigationController *)appNavigationController{
    UINavigationController *navVc = (UINavigationController *)[self appRootViewController];
    if([navVc isKindOfClass:[UINavigationController class]]){
        return navVc;
    }else if([navVc isKindOfClass:[UITabBarController class]]){
        id nav = [(UITabBarController *)navVc selectedViewController];
        if([nav isKindOfClass:[UINavigationController class]]){
            return nav;
        }
    }
    return nil;
}

+ (UIViewController *)appNavigationRootViewController{
    UINavigationController *navVc = [self appNavigationController];
    if(navVc){
        NSArray *viewControllers = [navVc viewControllers];
        return viewControllers.count?viewControllers[0]:nil;
    }
    return nil;
}

+ (UIViewController *)appNavigationTopViewController{
    UINavigationController *navVc = [self appNavigationController];
    if(navVc){
        return [navVc topViewController];
    }
    return nil;
}

+ (UIViewController *)appNavigationVisibleViewController{
    UINavigationController *navVc = [self appNavigationController];
    if(navVc){
        return [navVc visibleViewController];
    }
    return nil;
}

+ (UITabBarController *)appTabBarController{
    UITabBarController *tabVC = (UITabBarController *)[self appRootViewController];
    if([tabVC isKindOfClass:[UITabBarController class]]){
        return tabVC;
    }
    return nil;
}

+ (UIViewController *)appTabBarSelelctedViewController{
    UITabBarController *tabVc = [self appTabBarController];
    if(tabVc){
        return [tabVc selectedViewController];
    }
    return nil;
}

+ (UIViewController *)appTabBarTopViewController{
    UIViewController *vc = [self appTabBarSelelctedViewController];
    if([vc isKindOfClass:[UINavigationController class]]){
        return [(UINavigationController *)vc topViewController];
    }
    return vc;
}

+ (UIViewController *)appTabBarVisibleViewController{
    UIViewController *vc = [self appTabBarSelelctedViewController];
    if([vc isKindOfClass:[UINavigationController class]]){
        return [(UINavigationController *)vc visibleViewController];
    }
    return vc;
}

@end

@implementation UINavigationSetting

+ (instancetype)sharedNavigationSetting{
    static UINavigationSetting *navSetting = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navSetting = [[self alloc] init];
    });
    
    return navSetting;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _itemDefaultFrame = CGRectMake(0, 0, 30, 30);
        _titleDefaultColor = [UIColor blueColor];
        _barBgColor = [UIColor whiteColor];
        _titleDefaultFontSize = 16.0;
        _leftItemImage = nil;
    }
    return self;
}

@end

@implementation UIViewController (NavigationItemExtral)

///block asscoiation key
static const char *__navigationLeftBtnActionKey = "__navigationLeftBtnActionKey";
static const char *__navigationRightBtnActionKey = "__navigationRightBtnActionKey";

- (void)customNavigationBar{
    [self customNavigationBarWithBackgroundImage:nil];
}

- (void)customNavigationBarWithBackgroundImage:(UIImage *)bgImage{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    if(bgImage){
        [navBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    }
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [navBar setTranslucent:NO];
}

///设置通用的返回图片
+ (void)setLeftCustomerItemImage:(UIImage *)image{
    [UINavigationSetting sharedNavigationSetting].leftItemImage = image;
}

- (UIButton *)createLeftCustomerItemWithTarget:(id)target selector:(SEL)selector{
    __weak UINavigationSetting *navSetting = [UINavigationSetting sharedNavigationSetting];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:navSetting.itemDefaultFrame];
    [leftBtn setTitleColor:navSetting.titleDefaultColor forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:navSetting.titleDefaultFontSize]];
    [leftBtn setReversesTitleShadowWhenHighlighted:YES];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    [leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    return leftBtn;
}

- (UIButton *)setLeftCustomerItemTitle:(NSString *)title{
    UIButton *leftBtn = [self createLeftCustomerItemWithTarget:self selector:@selector(__btnLeftAction)];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    return leftBtn;
}

- (void)setLeftCustomerItem{
    UIImage *leftImage = [UINavigationSetting sharedNavigationSetting].leftItemImage;
    if(leftImage){
        [self setLeftCustomerItemImage:leftImage target:self selector:@selector(__btnLeftAction)];
    }
}

- (UIButton *)setLeftCustomerItemWithTarget:(id)target selector:(SEL)selector{
    UIButton *leftBtn = [self createLeftCustomerItemWithTarget:target selector:selector];
    return leftBtn;
}

- (UIButton *)setLeftCustomerItemTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    UIButton *leftBtn = [self createLeftCustomerItemWithTarget:target selector:selector];
    
    if(title && title.length){
        [leftBtn setTitle:title forState:UIControlStateNormal];
        [leftBtn sizeToFit];
    }
    
    return leftBtn;
}

- (UIButton *)setLeftCustomerItemImage:(UIImage *)leftImage target:(id)target selector:(SEL)selector{
    UIButton *leftBtn = [self createLeftCustomerItemWithTarget:target selector:selector];
    [leftBtn setImage:leftImage forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    return leftBtn;
}

- (void)__btnLeftAction{
    [self popSelf];
}

- (UIButton *)createRightItemWithTarget:(id)target selector:(SEL)selector{
    __weak UINavigationSetting *navSetting = [UINavigationSetting sharedNavigationSetting];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:navSetting.itemDefaultFrame];
    [rightBtn setTitleColor:navSetting.titleDefaultColor forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:navSetting.titleDefaultFontSize]];
    [rightBtn setReversesTitleShadowWhenHighlighted:YES];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
    return rightBtn;
}

- (UIButton *)setRightItemImage:(UIImage *)rightImg target:(id)target selector:(SEL)selector{
    UIButton *rightBtn = [self createRightItemWithTarget:target selector:selector];
    if(rightImg){
        [rightBtn setImage:rightImg forState:UIControlStateNormal];
        [rightBtn sizeToFit];
    }
    return rightBtn;
}

- (UIButton *)setRightItemTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    UIButton *rightBtn = [self createRightItemWithTarget:target selector:selector];
    
    if(title && title.length){
        [rightBtn setTitle:title forState:UIControlStateNormal];
        [rightBtn sizeToFit];
    }
    
    return rightBtn;
}

///block support  -  block handler more easy to do actions
- (UIButton *)setLeftCustomerItemWithHandler:(void (^)(id sender))clickHandler{
    if(clickHandler){
        objc_setAssociatedObject(self, __navigationLeftBtnActionKey, clickHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    UIButton *leftBtn = [self createLeftCustomerItemWithTarget:self selector:@selector(__leftNavigationItemBtnAction:)];
    
    UIImage *leftImage = [UINavigationSetting sharedNavigationSetting].leftItemImage;
    if(leftImage){
        [leftBtn setImage:leftImage forState:UIControlStateNormal];
        [leftBtn sizeToFit];
    }
    
    return leftBtn;
}

- (UIButton *)setLeftCustomerItemTitle:(NSString *)title handler:(void (^)(id sender))clickHandler{
    if(clickHandler){
        objc_setAssociatedObject(self, __navigationLeftBtnActionKey, clickHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return [self setLeftCustomerItemTitle:title target:self selector:@selector(__leftNavigationItemBtnAction:)];
}

- (UIButton *)setLeftCustomerItemImage:(UIImage *)leftImage handler:(void (^)(id sender))clickHandler{
    if(clickHandler){
        objc_setAssociatedObject(self, __navigationLeftBtnActionKey, clickHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return [self setLeftCustomerItemImage:leftImage target:self selector:@selector(__leftNavigationItemBtnAction:)];
}

- (UIButton *)setRightItemImage:(UIImage *)rightImg handler:(void (^)(id sender))clickHandler{
    if(clickHandler){
        objc_setAssociatedObject(self, __navigationRightBtnActionKey, clickHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return [self setRightItemImage:rightImg target:self selector:@selector(__rightNavigationItemBtnAction:)];
}

- (UIButton *)setRightItemTitle:(NSString *)title handler:(void (^)(id sender))clickHandler{
    if(clickHandler){
        objc_setAssociatedObject(self, __navigationRightBtnActionKey, clickHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return [self setRightItemTitle:title target:self selector:@selector(__rightNavigationItemBtnAction:)];
}

///block private method
- (void)__leftNavigationItemBtnAction:(id)sender{
    void (^clickHandler)(id sender) = objc_getAssociatedObject(self,__navigationLeftBtnActionKey);
    if(clickHandler){
        clickHandler(sender);
    }
}

- (void)__rightNavigationItemBtnAction:(id)sender{
    void (^clickHandler)(id sender) = objc_getAssociatedObject(self,__navigationRightBtnActionKey);
    if(clickHandler){
        clickHandler(sender);
    }
}

@end

@implementation UIViewController (NavigationBarExtral)

- (UINavigationBar *)navigationBar{
    return self.navigationController.navigationBar;
}

- (void)setNavigationTitleColor:(UIColor *)navigationTitleColor{
    if(!navigationTitleColor){
        return;
    }
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:navigationTitleColor}];///改变title颜色
    if([UIDevice isNotBelow7iOSVersion]){
        [self.navigationBar setTintColor:navigationTitleColor];
    }
}

- (UIColor *)navigationTitleColor{
    return self.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
}

- (void)setNavigationBgColor:(UIColor *)navigationBgColor{
    if(!navigationBgColor){
        return;
    }
    self.navigationBar.backgroundColor = navigationBgColor;
    if([UIDevice isNotBelow7iOSVersion]){
        [self.navigationBar setBarTintColor:navigationBgColor];
    }else{
        [self.navigationBar setTintColor:navigationBgColor];
    }
}

- (UIColor *)navigationBgColor{
    return self.navigationController.navigationBar.backgroundColor;
}

- (void)setNavigationBarTranslucent:(BOOL)navigationBarTranslucent{
    [self.navigationBar setTranslucent:navigationBarTranslucent];
}

- (BOOL)navigationBarTranslucent{
    return self.navigationBar.translucent;
}

+ (void)setNavigationTitleColor:(UIColor *)navTitleColor{
    if(!navTitleColor){
        return;
    }
    UINavigationBar *naviBar = [UINavigationBar appearance];
    if([UIDevice isNotBelow7iOSVersion]){
        [naviBar setTintColor:navTitleColor];
    }
    
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName:navTitleColor}];///改变title颜色
    
    [[UIBarButtonItem appearance] setTintColor:navTitleColor];///改变barButtonItem字体颜色
}

+ (void)setNavigationBgColor:(UIColor *)navBgColor{
    if(!navBgColor){
        return;
    }
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBackgroundColor:navBgColor];
    if([UIDevice isNotBelow7iOSVersion]){
        [naviBar setBarTintColor:navBgColor];
    }else{
        [naviBar setTintColor:navBgColor];
    }
}

+ (void)setNavigationTitleColor:(UIColor *)navTitleColor navigationBgColor:(UIColor *)navBgColor{
    [self setNavigationTitleColor:navTitleColor];
    [self setNavigationBgColor:navBgColor];
}

+ (void)setupNavigationBar{
    __weak UINavigationSetting *navSetting = [UINavigationSetting sharedNavigationSetting];
    
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setBackgroundColor:navSetting.barBgColor];
    if([UIDevice isNotBelow7iOSVersion]){
        [naviBar setBarTintColor:navSetting.barBgColor];
        [naviBar setTintColor:navSetting.titleDefaultColor];
    }else{
        [naviBar setTintColor:navSetting.barBgColor];
    }
    
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName:navSetting.titleDefaultColor}];///改变title颜色
    
    [[UIBarButtonItem appearance] setTintColor:navSetting.titleDefaultColor];///改变barButtonItem字体颜色
}

@end

@implementation UIViewController (NavigationTitleActivityIndicatorCategroy)
- (void)showTitleActivityIndicatorWithMessage:(NSString *)message textColor:(UIColor *)textColor style:(UIActivityIndicatorViewStyle)style{
    if(!message){// || ![message length]
        return;
    }
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIFont *font = [UIFont systemFontOfSize:16.0];
    CGSize constrainedSize = CGSizeMake(screenWidth - 90, CGFLOAT_MAX);
    NSLineBreakMode lineBreakMode = NSLineBreakByWordWrapping;
    CGSize fitSize;
    if ([message respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [message boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        fitSize = CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }else{
        fitSize = [message sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
    }
    
    CGFloat width = fitSize.width + 40;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(fitSize.width, 0, 40, 40)];
    activityView.backgroundColor = [UIColor clearColor];
    CGRect frame = CGRectZero;
    frame.size = fitSize;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    CGFloat top = 0.5 * (titleView.frame.size.height - fitSize.height);
    CGRect labelFrame = label.frame;
    labelFrame.origin.y = top;
    label.frame = labelFrame;
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.text = message;
    label.font = [UIFont systemFontOfSize:16.0];
    
    [titleView addSubview:label];
    [titleView addSubview:activityView];
    self.navigationItem.titleView = titleView;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    CGSize viewSize = activityView.frame.size;
    CGPoint center = CGPointMake(viewSize.width * .5f, viewSize.height * .5f);
    activityIndicator.center = center;

    [activityView addSubview:activityIndicator];;
    [activityIndicator startAnimating];///开始
}

- (void)hideTitleActivityIndicator{
    self.navigationItem.titleView = nil;
}

@end

@implementation  UIViewController (StatusBarStyle)

static char *__UIViewControllerStatusBarStyleRuntimeKey = "__UIViewControllerStatusBarStyleRuntimeKey";

+ (void)load{
    if([UIDevice isNotBelow7iOSVersion]){
        Method oldMethod = class_getInstanceMethod(self.class, @selector(preferredStatusBarStyle));
        Method newMethod = class_getInstanceMethod(self.class, @selector(__preferredStatusBarStyle));
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

+ (BOOL)viewControllerBasedStatusBarAppearance{
    id basedObj = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIViewControllerBasedStatusBarAppearance"];
    if(basedObj){
        return [basedObj boolValue];
    }else{
        /// iOS7-默认为NO,iOS7+默认为YES
        return [UIDevice isNotBelow7iOSVersion];
    }
}

- (BOOL)viewControllerBasedStatusBarAppearance{
    return [self.class viewControllerBasedStatusBarAppearance];
}

/// status bar
- (UIStatusBarStyle)statusBarStyle{
    if(self.viewControllerBasedStatusBarAppearance){
        if(self.navigationController && !self.navigationController.navigationBarHidden){
            UIBarStyle barStyle = self.navigationController.navigationBar.barStyle;
            UIStatusBarStyle statusBarStyle = UIStatusBarStyleDefault;
            if(UIBarStyleDefault != barStyle){
                statusBarStyle = UIStatusBarStyleLightContent;
            }
            return statusBarStyle;
        }
        
        if([self __statusBarStyleOfCached]){
            return [self __preferredStatusBarStyle];
        }else if([self respondsToSelector:@selector(preferredStatusBarStyle)]){
            return (UIStatusBarStyle)[[self performSelector:@selector(preferredStatusBarStyle)] integerValue];
        }else{
            return UIStatusBarStyleDefault;
        }
    }else{
        return [UIApplication sharedApplication].statusBarStyle;
    }
}

- (id)__statusBarStyleOfCached{
    return objc_getAssociatedObject(self, __UIViewControllerStatusBarStyleRuntimeKey);
}

- (void)__setStatusBarStyleOfCached:(UIStatusBarStyle)statusBarStyle{
    id obj = [self __statusBarStyleOfCached];
    if(obj){
        /// remove already exsit
        objc_setAssociatedObject(self, __UIViewControllerStatusBarStyleRuntimeKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    /// add key
    objc_setAssociatedObject(self, __UIViewControllerStatusBarStyleRuntimeKey, @(statusBarStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    if(self.viewControllerBasedStatusBarAppearance){
        if(self.navigationController/* && !self.navigationController.navigationBarHidden*/){
            UIBarStyle barStyle = UIBarStyleDefault;

            if(UIStatusBarStyleLightContent == statusBarStyle){
                barStyle = UIBarStyleBlack;
            }
            self.navigationController.navigationBar.barStyle = barStyle;
        }
        
        if([self respondsToSelector:@selector(preferredStatusBarStyle)]){
            [self __setStatusBarStyleOfCached:statusBarStyle];
            /// 开始调用
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }else{
        __weak UIApplication *app = [UIApplication sharedApplication];
        if(app.statusBarStyle != statusBarStyle){
            app.statusBarStyle = statusBarStyle;
        }
    }
}

- (UIStatusBarStyle)__preferredStatusBarStyle{
    id obj = [self __statusBarStyleOfCached];
    return obj?(UIStatusBarStyle)[obj integerValue]:UIStatusBarStyleDefault;
}

@end

