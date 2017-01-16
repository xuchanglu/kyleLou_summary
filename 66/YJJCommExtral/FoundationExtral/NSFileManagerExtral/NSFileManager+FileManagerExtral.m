//
//  NSFileManager+FileManagerExtral.m
//  BPC_ECRCOC
//
//  Created by YiJianjun on 14/12/15.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "NSFileManager+FileManagerExtral.h"

@implementation NSFileManager (FileManagerExtral)

+ (BOOL)hasDirPath:(NSString *)dirPath{
    if(!dirPath || ![dirPath length]){
        return NO;
    }
    __weak NSFileManager *fm = [self defaultManager];
    BOOL isDir;
    if([fm fileExistsAtPath:dirPath isDirectory:&isDir]){
        if(isDir){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)hasFilePath:(NSString *) filePath{
    if(!filePath || ![filePath length]){
        return NO;
    }
    __weak NSFileManager *fm = [self defaultManager];
    BOOL isDir;
    if([fm fileExistsAtPath:filePath isDirectory:&isDir]){
        if(!isDir){
            return YES;
        }
    }
    return NO;
}

+ (void)creatDirIfNeed:(NSString *)dir{
    if(!dir || ![dir length]){
        return;
    }
    __weak NSFileManager *fm = [self defaultManager];
    BOOL isDir;
    if([fm fileExistsAtPath:dir isDirectory:&isDir]){
        if(!isDir){
            if([fm removeItemAtPath:dir error:nil]){
                [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
    }else{
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (void)clearDir:(NSString *)dir{
    if(!dir || ![dir length]){
        return;
    }
    __weak NSFileManager *fm = [self defaultManager];
    NSDirectoryEnumerator *dirEnu = [fm enumeratorAtPath:dir];
    NSString *file;
    while ((file = dirEnu.nextObject)) {
        NSString *path = [dir stringByAppendingPathComponent:file];
        [fm removeItemAtPath:path error:nil];
    }
}

///root path
+ (NSString *)documentsRootPath{
    return [self rootPathForSearchPathDirectory:NSDocumentDirectory];
}

+ (NSString *)libraryCacheRootPath{
    return [self rootPathForSearchPathDirectory:NSCachesDirectory];
}

+ (NSString *)applicationSupportRootPath{
    return [self rootPathForSearchPathDirectory:NSApplicationSupportDirectory];
}

+ (NSString *)rootPathForSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory{
    return [self rootPathForSearchPathDirectory:searchPathDirectory userMask:NSUserDomainMask];
}

+ (NSString *)rootPathForSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory userMask:(NSSearchPathDomainMask)domainMask{
    NSArray *dirs = [[self defaultManager] URLsForDirectory:searchPathDirectory inDomains:domainMask];
    
    if(dirs && [dirs count]){
        NSURL *url = [dirs firstObject];
        
        if([url isFileURL]){
            return [url path];
        }else{
            return [url absoluteString];
        }
    }else{
        return nil;
    }
}

+ (unsigned long long)fileSizeForPath:(NSString *)path{
    __weak NSFileManager *fm = [self defaultManager];
    
    BOOL isDir = NO;
    if([fm fileExistsAtPath:path isDirectory:&isDir]){
        if(!isDir){
            NSDictionary *fileProperty = [fm attributesOfItemAtPath:path error:nil];
            
            return [fileProperty fileSize];
        }else{
            ///目录
            NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
            
            unsigned long long totalSize = 0;
            NSString *fileName = nil;
            while ((fileName = [dirEnum nextObject])) {
                if([fileName rangeOfString:@"/"].length){
                    continue;
                }
                
                NSString *filePath = [path stringByAppendingPathComponent:fileName];
                totalSize += [self fileSizeForPath:filePath];
            }
            
            return totalSize;
        }
    }
    return 0;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    if(![[self defaultManager] fileExistsAtPath: [URL path]]){
        return NO;
    }
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


@end
