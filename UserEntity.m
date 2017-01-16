//
//  UserEntity.m
//  rwd
//  用户实体实现文件
//  Created by 齐乐乐 on 15-3-27.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

+ (UserEntity *)shareInstance{
    static UserEntity *__shareInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareInstace = [[self alloc] init];
    });
    
    return __shareInstace;
}

///填充部分本地基本数据
- (NSString *)deviceID{
    if(!_deviceID){
        _deviceID = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    }
    
    return _deviceID;
}

- (NSString *)osVersion{
    if(!_osVersion){
        _osVersion = [[UIDevice currentDevice] systemVersion];
    }
    return _osVersion;
}

- (NSString *)appVersion{
    if(!_appVersion){
        _appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
    return _appVersion;
}

/// 设备类型(2 Android, 3 iOS)
- (NSString *)deviceType{
    if(!_deviceType){
        _deviceType = @"3";
    }
    
    return _deviceType;
}

/// 得到基础输入数据
+ (NSDictionary *)basicInputDataDict{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    __weak UserEntity *user = [UserEntity shareInstance];
    
    NSString *userID = user.userID;
    if(userID && [userID length]){
        dict[@"userID"] = userID;
    }
    
    NSString *deviceID = user.deviceID;
    if(deviceID && [deviceID length]){
        dict[@"deviceID"] = deviceID;
    }
    
    NSString *osVersion = user.osVersion;
    if(osVersion && [osVersion length]){
        dict[@"osVersion"] = osVersion;
    }
    
    NSString *appVersion = user.appVersion;
    if(appVersion && [appVersion length]){
        dict[@"appVersion"] = appVersion;
    }
    
    NSString *deviceType = user.deviceType;
    if(deviceType && [deviceType length]){
        dict[@"deviceType"] = deviceType;
    }
    
    return [dict copy];
}


@end
