//
//  UIViewController+PushExtra.h
//  VXiao
//
//  Created by TY on 14-1-2.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PushExtra)

- (void)navigationPushViewController:(Class)vcClass;
- (void)navigationPushViewController:(Class)vcClass animation:(BOOL)animation;
- (void)navigationPushViewController:(Class)vcClass withOperation:(void (^)(id vcInstance))operation;
- (void)navigationPushViewController:(Class)vcClass animation:(BOOL)animation withOperation:(void (^)(id vcInstance))operation;
/**
 *从vc导航到vcClass
 * @param vc 所在的UIViewController
 * @param vcClass 将要跳转的UIViewController
 * @return void
 * @see navigationViewController:pushViewController:withOperation:
 * @warning vc的navigationViewController应该非空并且vcClass应该是一种UIViewController
 **/
+ (void)navigationViewController:(UIViewController *)vc pushViewController:(Class)vcClass;

/**
 *从vc导航到vcClass
 * @param vc 所在的UIViewController
 * @param vcClass 将要跳转的UIViewController Class
 * @param animation 动画
* @param oparation 添加额外的操作,push之前
 * @return void
 * @see navigationViewController:pushViewController:
 * @warning vc的navigationViewController应该非空并且vcClass应该是一种UIViewController,operation可以为空
 **/
+ (void)navigationViewController:(UIViewController *)vc pushViewController:(Class)vcClass animation:(BOOL)animation withOperation:(nullable void (^)(id vcInstance))operation;

@end


@interface UIViewController (PopExtral)

- (nullable UIViewController *)popSelf;
- (nullable NSArray *)popToRootViewController;
- (nullable UIViewController *)poptoViewControllerWithIndex:(NSUInteger)index;

- (nullable UIViewController *)popSelfWithAnimation:(BOOL)animation;
- (nullable NSArray *)popSelfToRootViewControllerWithAnimation:(BOOL)animation;
- (nullable UIViewController *)poptoViewControllerWithIndex:(NSUInteger)index animation:(BOOL)animation;
@end

@interface UIViewController (PresentExtral)
- (void)presentViewController:(Class)vcClass;
- (void)presentViewController:(Class)vcClass withOperation:(nullable void (^)(id presentedVC))operation;
- (void)presentViewController:(Class)vcClass animation:(BOOL)animation;
- (void)presentViewController:(Class)vcClass animation:(BOOL)animation withOperation:(nullable void(^)(id presentedVC))operation;
@end

@interface UIViewController (AppExtral)

+ (nullable id<UIApplicationDelegate> )appDelegate;
+ (UIWindow *)appWindow;
+ (nullable UIViewController *)appRootViewController;

///navigation
+ (nullable UINavigationController *)appNavigationController;
+ (nullable UIViewController *)appNavigationRootViewController;
+ (nullable UIViewController *)appNavigationTopViewController;
+ (nullable UIViewController *)appNavigationVisibleViewController;

///tabBarController
+ (nullable UITabBarController *)appTabBarController;
+ (nullable UIViewController *)appTabBarSelelctedViewController;
+ (nullable UIViewController *)appTabBarTopViewController;
+ (nullable UIViewController *)appTabBarVisibleViewController;
@end

/// UINavigation settings
@interface UINavigationSetting : NSObject
/// UINavgationItemDefaultFrame
@property (nonatomic,assign) CGRect itemDefaultFrame;
/// UINavgationTitleDefaultColor
@property (nonatomic,strong) UIColor *titleDefaultColor;
/// UINavgationBarBgColor
@property (nonatomic,strong) UIColor *barBgColor;
/// UINavgationTitleDefualtFontSize
@property (nonatomic,assign) CGFloat titleDefaultFontSize;
/// navigation left item image
@property (nonatomic,strong) UIImage *leftItemImage;

+ (instancetype)sharedNavigationSetting;

@end

@interface UIViewController (NavigationItemExtral)

- (void)customNavigationBar;
- (void)customNavigationBarWithBackgroundImage:(nullable UIImage *)bgImage;

///设置通用的返回图片
+ (void)setLeftCustomerItemImage:(UIImage *)image;
///自定义左item
- (void)setLeftCustomerItem;
- (UIButton *)setLeftCustomerItemTitle:(NSString *)title;
///使用通用的图片
- (UIButton *)setLeftCustomerItemWithTarget:(id)target selector:(SEL)selector;
- (UIButton *)setLeftCustomerItemTitle:(NSString *)title target:(id)target selector:(SEL)selector;
- (UIButton *)setLeftCustomerItemImage:(UIImage *)leftImage target:(id)target selector:(SEL)selector;

- (UIButton *)setRightItemImage:(UIImage *)rightImg target:(id)target selector:(SEL)selector;
- (UIButton *)setRightItemTitle:(NSString *)title target:(id)target selector:(SEL)selector;

///block support  -  block handler more easy to do actions
- (UIButton *)setLeftCustomerItemWithHandler:(void (^)(id sender))clickHandler;
- (UIButton *)setLeftCustomerItemTitle:(NSString *)title handler:(void (^)(id sender))clickHandler;
- (UIButton *)setLeftCustomerItemImage:(UIImage *)leftImage handler:(void (^)(id sender))clickHandler;

- (UIButton *)setRightItemImage:(UIImage *)rightImg handler:(void (^)(id sender))clickHandler;
- (UIButton *)setRightItemTitle:(NSString *)title handler:(void (^)(id sender))clickHandler;

@end

@interface UIViewController (NavigationBarExtral)

@property (nonatomic,strong,readonly) UINavigationBar *navigationBar;
@property (nonatomic,strong,readwrite) UIColor *navigationTitleColor;
@property (nonatomic,strong,readwrite) UIColor *navigationBgColor;

@property (nonatomic,assign,readwrite) BOOL navigationBarTranslucent;

+ (void)setNavigationTitleColor:(UIColor *)navTitleColor;
+ (void)setNavigationBgColor:(UIColor *)navBgColor;
+ (void)setNavigationTitleColor:(UIColor *)navTitleColor navigationBgColor:(UIColor *)navBgColor;
///setup navgation bar
+ (void)setupNavigationBar;
@end

@interface UIViewController (NavigationTitleActivityIndicatorCategroy)
- (void)showTitleActivityIndicatorWithMessage:(NSString *)message textColor:(UIColor *)textColor style:(UIActivityIndicatorViewStyle)style;
- (void)hideTitleActivityIndicator;
@end

/**
 info.plist文件中，View controller-based status bar appearance项默认为YES,则application设置无效
 **/
@interface UIViewController (StatusBarStyle)
/// status bar
@property (nonatomic,assign,readwrite) UIStatusBarStyle statusBarStyle;

/**  View controller-based status bar appearance  - UIViewControllerBasedStatusBarAppearance
 info.plist文件中，View controller-based status bar appearance项设为YES，则View controller对status bar的设置优先级高于application的设置。为NO则以application的设置为准，view controller的prefersStatusBarHidden方法无效，是根本不会被调
 
 UINavigationController不会将 preferredStatusBarStyle方法调用转给它的子视图,而是由它自己管理状态,而且它也应该那样做.因为UINavigationController 包含了它自己的状态栏
 因此就算 UINavigationController中的viewController 实现了 preferredStatusBarStyle方法 也不会调用
 那 UINavigationController是怎么决定 该返回 UIStatusBarStyleLightContent 还是 UIStatusBarStyleDefault的呢? 它是基于它的 UINavigationBar.barStyle属性.默认(UIBarStyleDefault)的是黑色文本的状态栏 而 UIBarStyleBlack是设置为白色文本的状态栏
 **/
@property (nonatomic,assign,readonly) BOOL viewControllerBasedStatusBarAppearance;


+ (BOOL)viewControllerBasedStatusBarAppearance;
@end


NS_ASSUME_NONNULL_END
