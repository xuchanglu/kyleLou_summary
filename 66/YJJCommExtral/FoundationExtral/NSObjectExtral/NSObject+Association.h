//
//  NSObject+Association.h
//
//  Created by Maciej Swic on 03/12/13.
//  Released under the MIT license.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Association)
- (nullable id)associatedObjectForKey:(nonnull NSString *)key;
- (void)setAssociatedObject:(nonnull id)object forKey:(nonnull NSString *)key;
@end

NS_ASSUME_NONNULL_END
