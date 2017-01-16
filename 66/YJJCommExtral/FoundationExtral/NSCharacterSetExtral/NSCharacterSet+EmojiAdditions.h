//
//  NSCharacterSet+EmojiAdditions.h
//  CoreTextEmoji
//
//  Created by Luo Sheng on 12-11-22.
//  Copyright (c) 2012年 CodeLeaks. All rights reserved.
//
//  Portions copyright (c) 2012 Kristian Trenskow. All rights reserved.
//  http://trenskow.com/emoji-nscharacterset-objective-c-category/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCharacterSet (EmojiAdditions)

+ (instancetype)emojiCharacterSet;

@end

NS_ASSUME_NONNULL_END
