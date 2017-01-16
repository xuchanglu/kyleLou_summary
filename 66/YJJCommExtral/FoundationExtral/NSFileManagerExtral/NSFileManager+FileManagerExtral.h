//
//  NSFileManager+FileManagerExtral.h
//  BPC_ECRCOC
//
//  Created by YiJianjun on 14/12/15.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (FileManagerExtral)

///file
+ (BOOL)hasFilePath:(NSString *)filePath;

///dir
+ (BOOL)hasDirPath:(NSString *)dirPath;
+ (void)creatDirIfNeed:(NSString *)dir;
+ (void)clearDir:(NSString *)dir;

///root path
+ (NSString *)documentsRootPath;
+ (NSString *)libraryCacheRootPath;
+ (NSString *)applicationSupportRootPath;
+ (NSString *)rootPathForSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;
+ (NSString *)rootPathForSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory userMask:(NSSearchPathDomainMask)domainMask;

///bytes,path is dir or file
+ (unsigned long long)fileSizeForPath:(NSString *)path;


/// skipt backup - 	2.23 - Apps must follow the iOS Data Storage Guidelines or they will be rejected
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
