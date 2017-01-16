//
//  NSObject+Association.m
//
//  Created by Maciej Swic on 03/12/13.
//  Released under the MIT license.
//

#import "NSObject+Association.h"
#import <objc/runtime.h>

@implementation NSObject (Association)

static const char *__associatedObjectsKey = "__associatedObjectsKey__";

- (id)associatedObjectForKey:(NSString *)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, __associatedObjectsKey);
    return [dict objectForKey:key];
}

- (void)setAssociatedObject:(id)object forKey:(NSString *)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, __associatedObjectsKey);
    if (!dict) {
      dict = [[NSMutableDictionary alloc] init];
      objc_setAssociatedObject(self, &__associatedObjectsKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [dict setObject:object forKey:key];
}

@end
