//
//  NSData+DataExtral.h
//  BPC-4S-W
//
//  Created by YiJianJun on 14-7-4.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ///amrnb
    Data_Audio_Type_AMRNB,
    ///amrwb
    Data_Audio_Type_AMRWB,
    ///wav
    Data_Audio_Type_WAV,
    ///caf
    Data_Audio_Type_CAF,
    ///unkown
    Data_Audio_Type_Unkown,
    ///invaild
    Data_Audio_Type_invalid
} Data_Audio_Type;

typedef enum : NSUInteger {
    Data_Image_Type_PNG,
    Data_Image_Type_JPEG,
    Data_Image_Type_GIF,
    Data_Image_Type_BMP,
    Data_Image_Type_ICO,
    Data_Image_Type_TGA,
    Data_Image_Type_TIFF,
    Data_Image_Type_PCX,
    Data_Image_Type_CUR,
    Data_Image_Type_IFF,
    Data_Image_Type_ANI,
    Data_Image_Type_Unkown,
    Data_Image_Type_Invaild
} Data_Image_Type;

NS_ASSUME_NONNULL_BEGIN

@interface NSData (DataExtral)
- (BOOL)isEmpty;
@end

@interface NSData (AudioDataExtral)

+ (Data_Audio_Type)dataAudioTypeContentOfPath:(NSString *)path;
- (Data_Audio_Type)dataAudioType;

+ (NSString *)dataAudioTypeDescription:(Data_Audio_Type)type;
+ (NSString *)extensionOfAudioType:(Data_Audio_Type)type;
@end

@interface NSData (ImageDataExtral)
+ (Data_Image_Type)dataImageTypeContentOfPath:(NSString *)path;
- (Data_Image_Type)dataImageType;

+ (NSString *)dataImageTypeDescription:(Data_Image_Type)type;
+ (NSString *)extensionOfImageType:(Data_Image_Type)type;
@end

@interface NSData (MKNKBase64)

+ (instancetype)mk_dataFromBase64String:(NSString *)aString;
- (NSString *)mk_base64EncodedString;

@end

@interface NSData (Base64DataExtral)
+ (instancetype)base64DecodeDataFromString:(NSString *)base64String;
- (NSString *)base64EncodeString;
@end

NS_ASSUME_NONNULL_END
