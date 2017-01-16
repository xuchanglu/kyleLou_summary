//
//  UserEntity.h
//  rwd
//  用户实体头文件
//  Created by 齐乐乐 on 15-3-27.
//  Copyright (c) 2015年 yasin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject{
}
//------------- 设备信息 -----------------------------
@property(nonatomic, strong) NSString *deviceID;            //设备uuid
@property(nonatomic, strong) NSString *osVersion;           //iOS版本
@property(nonatomic, strong) NSString *appVersion;          //APP版本
@property(nonatomic, strong) NSString *deviceType;          //设备类型
@property(nonatomic, strong) NSString *userID;              //用户ID
//获取用户实体的单例
+ (UserEntity *)shareInstance;
/// 得到基础输入数据
+ (NSDictionary *)basicInputDataDict;

@end
