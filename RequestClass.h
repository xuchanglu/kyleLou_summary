//
//  RequestClass.m
//  BeautyfulLife_1
//
//  Created by boombox
//  Copyrigrights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kResultCode;             /**< 返回数据编码，0为成功，其他为失败 */
extern NSString *const kErrorMessage;           /**< 错误描述 */


extern NSString *const login_interface;         /**< 登陆 */
extern NSString *const register_interface;      /**< 注册 */
extern NSString *const index_logout;            /**< 退出登录*/
extern NSString *const index_modPassword;       /**< 修改密码*/
extern NSString *const index_sendCaptcha;       /**< 获取验证码*/
extern NSString *const user_info;               /**< 用户基本信息 */

extern NSString *const homePage;                /**< 首页 */
extern NSString *const home_newsList;           /**< 新闻列表 */
extern NSString *const fuwuList;                /**< 服务合同 */
extern NSString *const daichiList;              /**< dd合同 */
extern NSString *const userCenter;              /**< 个人中心 */
extern NSString *const modifyPassword;          /**< 修改密码 */
extern NSString *const resetPassword;           /**< 忘记密码 */
/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger, RequestMethod){
    /**
     *  get请求
     */
    RequestMethodGet,
    /**
     *  post请求
     */
    RequestMethodPost,
    /**
     *  put请求
     */
    RequestMethodPut,
    /**
     *  delete请求
     */
    RequestMethodDelte
};

@interface RequestClass : NSObject

/**
 *  发送请求
 *
 *  @param method   请求方式
 *  @param url      请求的url
 *  @param params   请求参数
 *  @param callback 请求回调
 */
+ (void)requestWithMethod:(RequestMethod)method url:(NSString *)url params:(NSDictionary*)params block:(void(^)(BOOL success, id json))callback;

//上传多张图片图片至远程服务器
+(void)uploadImageToSerice:(RequestMethod)method urlString:(NSString *)urlString parms:(NSDictionary *)params imageData:(NSData*)imageData block:(void (^)(BOOL success, id json))callback;

/*******************接口集合*******************/

@end
