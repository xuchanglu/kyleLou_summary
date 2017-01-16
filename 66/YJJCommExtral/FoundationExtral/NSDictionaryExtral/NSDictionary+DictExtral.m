//
//  NSDictionary+DictExtral.m
//  BPC-4S-W
//
//  Created by YiJianJun on 14-8-13.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "NSDictionary+DictExtral.h"
#import "NSString+NSStringExtras.h"

@implementation NSDictionary (DictExtral)
/// 根据key
- (id)safeObjectForKey:(id)aKey{
    if(!aKey){
        return nil;
    }
    return [self objectForKey:aKey];
}

- (id)objectForKeyedSubscript:(id)key{
    return [self safeObjectForKey:key];
}
@end


@implementation NSDictionary (RequestEncoding)

-(NSString*) urlEncodedKeyValueString {
    
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in self) {
        
        NSObject *value = [self valueForKey:key];
        if([value isKindOfClass:[NSString class]])
            [string appendFormat:@"%@=%@&", [key mk_urlEncodedString], [((NSString*)value) mk_urlEncodedString]];
        else
            [string appendFormat:@"%@=%@&", [key mk_urlEncodedString], value];
    }
    
    if([string length] > 0)
        [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];
    
    return string;
}


-(NSString*) jsonEncodedKeyValueString {
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0 // non-pretty printing
                                                     error:&error];
    if(error)
        NSLog(@"JSON Parsing Error:%@",error);
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


-(NSString*) plistEncodedKeyValueString {
    
    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0 error:&error];

    if(error)
        NSLog(@"JSON Parsing Error:%@",error);
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end