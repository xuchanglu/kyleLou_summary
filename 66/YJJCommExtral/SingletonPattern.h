//
//  SingletonPattern.h
//
//  Created by TY on 13-9-26.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//

#ifndef SingletonPattern_h
#define SingletonPattern_h

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
}\
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}\
\


#endif
