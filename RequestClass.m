//
//  RequestClass.m
//  BeautyfulLife_1
//
//  Created by boombox
//  Copyrigrights reserved.
//

#define RWD_APP_SERVER_URL          @""

#import "RequestClass.h"
#import "AFNetworking.h"
#import "UserEntity.h"
NSString *const kResultCode          = @"flag";
NSString *const kErrorMessage        = @"note";
// 登录，注册，验证吗
NSString *const login_interface      = @"login";
NSString *const register_interface   = @"RegisterUser";
NSString *const index_logout         = @"index/logout";
NSString *const index_modPassword    = @"index/modPassword";
NSString *const index_sendCaptcha    = @"index/sendCaptcha";
NSString *const user_info            = @"user/info";
// 首页
NSString *const homePage             = @"homePage";
// 新闻列表
NSString *const home_newsList        = @"newsList";
// 服务合同
NSString *const fuwuList             = @"fuwuList";
// dd合同
NSString *const daichiList             = @"daichiList";
// 个人中心
NSString *const userCenter             = @"userCenter";
// 修改密码
NSString *const modifyPassword             = @"modifyPassword";
// 忘记密码
NSString *const resetPassword             = @"resetPassword";

@implementation RequestClass

+ (void)requestWithMethod:(RequestMethod)method url:(NSString *)url params:(NSDictionary *)extParam block:(void (^)(BOOL, id))callback{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];  //显示网络活动标志
     url = [RWD_APP_SERVER_URL stringByAppendingString:url];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *params = [[UserEntity basicInputDataDict] mutableCopy];
    if(extParam && [extParam count]){
        [params addEntriesFromDictionary:extParam];
    }

    
    NSLog(@"requestUrl = %@ \n requestParams = %@", url,params);
    if (method == RequestMethodPost) {
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self analysisJson:responseObject block:callback];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"\n------------请求失败------------\nurl：%@\n参数：%@\n错误信息：%@",url,params,[error localizedDescription]);
            callback(NO, error.localizedDescription);
        }];
    }else if (method == RequestMethodGet){
        [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self analysisJson:responseObject block:callback];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"\n------------请求失败------------\nurl：%@\n参数：%@\n错误信息：%@",url,params,[error localizedDescription]);
            callback(NO, error.localizedDescription);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
    }else if (method == RequestMethodPut){
        [manager PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self analysisJson:responseObject block:callback];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"\n------------请求失败------------\nurl：%@\n参数：%@\n错误信息：%@",url,params,[error localizedDescription]);
            callback(NO, error.localizedDescription);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
    }else{
        [manager DELETE:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self analysisJson:responseObject block:callback];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"\n------------请求失败------------\nurl：%@\n参数：%@\n错误信息：%@",url,params,[error localizedDescription]);
            callback(NO, error.localizedDescription);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
    }
}

+ (void)analysisJson:(id)responseObject block:(void (^)(BOOL, id))callback{
    id json = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        json = responseObject;
    }else{
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        json = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    }
    NSLog(@"json = %@",json);
    callback(YES, json);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

//上传多张图片图片至远程服务器
+(void)uploadImageToSerice:(RequestMethod)method urlString:(NSString *)urlString parms:(NSDictionary *)params imageData:(NSData*)imageData block:(void (^)(BOOL success, id json))callback{
   // urlString = [interface_url_prefix stringByAppendingString:urlString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id json = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            json = responseObject;
        }else{
            json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        }
        NSLog(@"json = %@",json);
        if ([json[@"resultCode"] intValue] == 0) {
            if (callback) {
                callback(YES, json);
            }
        }else{
            if (callback) {
                callback(NO, json[@"message"]);
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (callback) {
            callback(NO, error.localizedDescription);
        }
        NSLog(@"\n------------请求失败------------\nurl：%@\n错误信息：%@",urlString,error);
    }];
}

@end


