//
//  NSData+DataExtral.m
//  BPC-4S-W
//
//  Created by YiJianJun on 14-7-4.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "NSData+DataExtral.h"

#ifndef IsAboveIOSVersion
    ///IOS __version__以上
    #define IsAboveIOSVersion(__version__) ([[[UIDevice currentDevice] systemVersion] floatValue] >= (__version__))
    ///IOS 7.0以上
    #define IsIOSAbove7Version IsAboveIOSVersion(7.0f)//([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#endif

@implementation NSData (DataExtral)
- (BOOL)isEmpty{
    if(self && self.length){
        return NO;
    }
    return YES;
}

@end

@implementation NSData (AudioDataExtral)

+ (Data_Audio_Type)dataAudioTypeContentOfPath:(NSString *)path{
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(!data){
        return Data_Audio_Type_invalid;
    }
    return [data dataAudioType];
}

- (Data_Audio_Type)dataAudioType{
    if(!self.length){
        return Data_Audio_Type_invalid;
    }
    
    static const char *amrnb_header = "#!AMR\n";///6
    static const char *amrwb_header = "#!AMR-WB\n";///9
    static const char *caff_header = "caff";///4
    
    char header[9] = {0};
    [self getBytes:header length:9];
    
    if(!strncmp(amrnb_header, header,6)){
        return Data_Audio_Type_AMRNB;
    }else if(!strcmp(amrwb_header, header)){
        return Data_Audio_Type_AMRWB;
    }else if(!strncmp(caff_header, header, 4)){
        return Data_Audio_Type_CAF;
    }
    
    ///wav
    {
        char riff[4] = {0};
        char wave[4] = {0};
        char fmt[3] = {0};
        
        unsigned int pt = 0;
        [self getBytes:riff length:sizeof(riff)];
        pt += strlen(riff) + 32;
        
        [self getBytes:wave range:NSMakeRange(pt, sizeof(wave))];
        pt += strlen(wave);
        
        [self getBytes:fmt range:NSMakeRange(pt, sizeof(fmt))];
        
        if(!strcmp(riff, "RIFF") && !strcmp(wave, "WAVE") && !strcmp(fmt, "fmt")){
            return Data_Audio_Type_WAV;
        }
    }

    
    return Data_Audio_Type_Unkown;
}

+ (NSString *)dataAudioTypeDescription:(Data_Audio_Type)type{
    NSString *des = @"未知音频";
    
    switch (type) {
        case Data_Audio_Type_AMRNB:
            des = @"窄带AMR(amrnb)";
            break;
        case Data_Audio_Type_AMRWB:
            des = @"宽带AMR(amrwb)";
            break;
        case Data_Audio_Type_CAF:
            des = @"core audio file(caf)";
            break;
        case Data_Audio_Type_WAV:
            des = @"波形音频(wav)";
            break;
        case Data_Audio_Type_invalid:
            des = @"无效的音频";
            break;
        default:
            break;
    }
    return des;
}

+ (NSString *)extensionOfAudioType:(Data_Audio_Type)type{
    NSString *ext = nil;
    switch (type) {
        case Data_Audio_Type_AMRNB://窄带AMR(amrnb)
        case Data_Audio_Type_AMRWB://宽带AMR(amrwb)
            ext = @"amr";
            break;
        case Data_Audio_Type_CAF://core audio file(caf)
            ext = @"caf";
            break;
        case Data_Audio_Type_WAV:///波形音频(wav)
            ext = @"wav";
            break;
        default:
            break;
    }
    return ext;
}
@end

@implementation NSData (ImageDataExtral)

+ (Data_Image_Type)dataImageTypeContentOfPath:(NSString *)path{
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(!data){
        return Data_Image_Type_Unkown;
    }
    return [data dataImageType];
}


- (Data_Image_Type)dataImageType{
    if(!self.length){
        return Data_Image_Type_Invaild;
    }
    UIImage *image = [UIImage imageWithData:self];
    if(!image){
        return Data_Image_Type_Invaild;
    }
    image = nil;
    
    char head[8] = {0};
    [self getBytes:head length:8];
    
    ///PNG - 文件头标识 (8 bytes) 89 50 4E 47 0D 0A 1A 0A
    static char png_head[8] = {0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A};
    if(!strcmp(head, png_head)){
        return Data_Image_Type_PNG;
    }
    
    ///JPEG - 文件头标识 (2 bytes): 0xff, 0xd8 (SOI)
    static char jpeg_head[2] = {0xff,0xd8};
    if(!strncmp(jpeg_head, head, sizeof(jpeg_head))){
        return Data_Image_Type_JPEG;
    }
    
    ///GIF - 文件头标识 (6 bytes) 47 49 46 38 39(37) 61
    static char gif_head[4] = {0x47,0x49,0x46,0x38};
    static char gif_head_6 = 0x61;
    
    if(!strncmp(gif_head, head, sizeof(gif_head)) && (head[4] == 0x39 || head[4] == 0x37) && head[5] == gif_head_6){
        return Data_Image_Type_GIF;
    }
    
    ///BMP - 文件头标识 (2 bytes) 42 4D
    static char bmp_head[2] = {0x42,0x4D};
    if(!strncmp(bmp_head, head, sizeof(bmp_head))){
        return Data_Image_Type_BMP;
    }
    
    ///ICO - 文件头标识 (8 bytes) 00 00 01 00 01 00 20 20
    static char ico_head[8] = {0x00,0x00,0x01,0x00,0x01,0x00,0x20,0x20};
    if(!strcmp(ico_head, head)){
        return Data_Image_Type_ICO;
    }
    
    ///TGA - 未压缩的前5字节: 00 00 02 00 00 - RLE压缩的前5字节: 00 00 10 00 00
    if(!head[0] && !head[1] && (head[2] == 0x02 || head[2] == 0x10) && !head[3] && !head[4]){
        return Data_Image_Type_TGA;
    }
    
    ///TIFF - 文件头标识 (2 bytes) 4D 4D 或 49 49
    if((head[0] == 0x4D && head[1] == 0x4D) || (head[0] == 0x49 && head[1] == 0x49)){
        return Data_Image_Type_TIFF;
    }
    
    ///PCX - 文件头标识 (1 bytes) 0A
    if(head[0] == 0x0A){
        return Data_Image_Type_PCX;
    }
    
    ///CUR - 文件头标识 (8 bytes)  00 00 02 00 01 00 20 20
    static char cur_head[8] = {0x00,0x00,0x02,0x00,0x01,0x00,0x20,0x20};
    if(!strcmp(cur_head, head)){
        return Data_Image_Type_CUR;
    }
    
    ///IFF - 文件头标识 (4 bytes) 46 4F 52 4D - F O R M
    static char iff_head[4] = {0x46,0x4F,0x52,0x4D};
    if(!strncmp(iff_head, head, sizeof(iff_head))){
        return Data_Image_Type_IFF;
    }
    
    ///ANI - 文件头标识 (4 bytes) 52 49 46 46- R I F F
    static char ani_head[4] = {0x52,0x49,0x46,0x46};
    if(!strncmp(ani_head, head, sizeof(ani_head))){
        return Data_Image_Type_ANI;
    }
    
    return Data_Image_Type_Unkown;
}

+ (NSString *)dataImageTypeDescription:(Data_Image_Type)type{
    NSString *des = [self extensionOfImageType:type];
    if(!des){
        des = @"未知图片格式或者无效图片";
    }else{
        des = [NSString stringWithFormat:@"%@图片",des];
    }
    /**
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
    Data_Image_Type_Unkown
    
    switch (type) {
        case Data_Image_Type_PNG:
            break;
        case Data_Image_Type_JPEG:
            break;
        case Data_Image_Type_GIF:
            break;
        case Data_Image_Type_BMP:
            break;
        case Data_Image_Type_ICO:
            break;
        case Data_Image_Type_TGA:
            break;
        case Data_Image_Type_TIFF:
            break;
        case Data_Image_Type_PCX:
            break;
        case Data_Image_Type_CUR:
            break;
        case Data_Image_Type_IFF:
            break;
        case Data_Image_Type_ANI:
            break;
        case Data_Image_Type_Unkown:
        default:
            break;
    }**/
    return des;
}

+ (NSString *)extensionOfImageType:(Data_Image_Type)type{
    NSString *ext = nil;
    switch (type) {
        case Data_Image_Type_PNG:
            ext = @"png";
            break;
        case Data_Image_Type_JPEG:
            ext = @"jpg";
            break;
        case Data_Image_Type_GIF:
            ext = @"gif";
            break;
        case Data_Image_Type_BMP:
            ext = @"bmp";
            break;
        case Data_Image_Type_ICO:
            ext = @"ico";
            break;
        case Data_Image_Type_TGA:
            ext = @"tga";
            break;
        case Data_Image_Type_TIFF:
            ext = @"tiff";
            break;
        case Data_Image_Type_PCX:
            ext = @"pcx";
            break;
        case Data_Image_Type_CUR:
            ext = @"cur";
            break;
        case Data_Image_Type_IFF:
            ext = @"iff";
            break;
        case Data_Image_Type_ANI:
            ext = @"ani";
            break;
        case Data_Image_Type_Unkown:
        case Data_Image_Type_Invaild:
        default:
            break;
    }
    return ext;
}
@end


@implementation NSData (MKNKBase64)

//
// Mapping from 6 bit pattern to ASCII character.
//
static unsigned char mk_base64EncodeLookup[65] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

//
// Definition for "masked-out" areas of the base64DecodeLookup mapping
//
#define xx 65

//
// Mapping from ASCII character to 6 bit pattern.
//
static unsigned char mk_base64DecodeLookup[256] =
{
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx,
    xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx,
    xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
};

//
// Fundamental sizes of the binary and base64 encode/decode units in bytes
//
#define BINARY_UNIT_SIZE 3
#define BASE64_UNIT_SIZE 4

//
// NewBase64Decode
//
// Decodes the base64 ASCII string in the inputBuffer to a newly malloced
// output buffer.
//
//  inputBuffer - the source ASCII string for the decode
//	length - the length of the string or -1 (to specify strlen should be used)
//	outputLength - if not-NULL, on output will contain the decoded length
//
// returns the decoded buffer. Must be free'd by caller. Length is given by
//	outputLength.
//
void *mk_NewBase64Decode(
                         const char *inputBuffer,
                         size_t length,
                         size_t *outputLength)
{
    if (length == (size_t)-1)
    {
        length = strlen(inputBuffer);
    }
    
    size_t outputBufferSize =
    ((length+BASE64_UNIT_SIZE-1) / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE;
    unsigned char *outputBuffer = (unsigned char *)malloc(outputBufferSize);
    
    size_t i = 0;
    size_t j = 0;
    while (i < length)
    {
        //
        // Accumulate 4 valid characters (ignore everything else)
        //
        unsigned char accumulated[BASE64_UNIT_SIZE];
        size_t accumulateIndex = 0;
        while (i < length)
        {
            unsigned char decode = mk_base64DecodeLookup[inputBuffer[i++]];
            if (decode != xx)
            {
                accumulated[accumulateIndex] = decode;
                accumulateIndex++;
                
                if (accumulateIndex == BASE64_UNIT_SIZE)
                {
                    break;
                }
            }
        }
        
        //
        // Store the 6 bits from each of the 4 characters as 3 bytes
        //
        // (Uses improved bounds checking suggested by Alexandre Colucci)
        //
        if(accumulateIndex >= 2)
            outputBuffer[j] = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);
        if(accumulateIndex >= 3)
            outputBuffer[j + 1] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);
        if(accumulateIndex >= 4)
            outputBuffer[j + 2] = (unsigned char)(accumulated[2] << 6) | accumulated[3];
        j += accumulateIndex - 1;
    }
    
    if (outputLength)
    {
        *outputLength = j;
    }
    return outputBuffer;
}

//
// NewBase64Encode
//
// Encodes the arbitrary data in the inputBuffer as base64 into a newly malloced
// output buffer.
//
//  inputBuffer - the source data for the encode
//	length - the length of the input in bytes
//  separateLines - if zero, no CR/LF characters will be added. Otherwise
//		a CR/LF pair will be added every 64 encoded chars.
//	outputLength - if not-NULL, on output will contain the encoded length
//		(not including terminating 0 char)
//
// returns the encoded buffer. Must be free'd by caller. Length is given by
//	outputLength.
//
char *mk_NewBase64Encode(
                         const void *buffer,
                         size_t length,
                         bool separateLines,
                         size_t *outputLength)
{
    const unsigned char *inputBuffer = (const unsigned char *)buffer;
    
#define MAX_NUM_PADDING_CHARS 2
#define OUTPUT_LINE_LENGTH 64
#define INPUT_LINE_LENGTH ((OUTPUT_LINE_LENGTH / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE)
#define CR_LF_SIZE 2
    
    //
    // Byte accurate calculation of final buffer size
    //
    size_t outputBufferSize =
    ((length / BINARY_UNIT_SIZE)
     + ((length % BINARY_UNIT_SIZE) ? 1 : 0))
    * BASE64_UNIT_SIZE;
    if (separateLines)
    {
        outputBufferSize +=
        (outputBufferSize / OUTPUT_LINE_LENGTH) * CR_LF_SIZE;
    }
    
    //
    // Include space for a terminating zero
    //
    outputBufferSize += 1;
    
    //
    // Allocate the output buffer
    //
    char *outputBuffer = (char *)malloc(outputBufferSize);
    if (!outputBuffer)
    {
        return NULL;
    }
    
    size_t i = 0;
    size_t j = 0;
    const size_t lineLength = separateLines ? INPUT_LINE_LENGTH : length;
    size_t lineEnd = lineLength;
    
    while (true)
    {
        if (lineEnd > length)
        {
            lineEnd = length;
        }
        
        for (; i + BINARY_UNIT_SIZE - 1 < lineEnd; i += BINARY_UNIT_SIZE)
        {
            //
            // Inner loop: turn 48 bytes into 64 base64 characters
            //
            outputBuffer[j++] = (char)mk_base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
            outputBuffer[j++] = (char)mk_base64EncodeLookup[((inputBuffer[i] & 0x03) << 4)
                                                            | ((inputBuffer[i + 1] & 0xF0) >> 4)];
            outputBuffer[j++] = (char)mk_base64EncodeLookup[((inputBuffer[i + 1] & 0x0F) << 2)
                                                            | ((inputBuffer[i + 2] & 0xC0) >> 6)];
            outputBuffer[j++] = (char)mk_base64EncodeLookup[inputBuffer[i + 2] & 0x3F];
        }
        
        if (lineEnd == length)
        {
            break;
        }
        
        //
        // Add the newline
        //
        outputBuffer[j++] = '\r';
        outputBuffer[j++] = '\n';
        lineEnd += lineLength;
    }
    
    if (i + 1 < length)
    {
        //
        // Handle the single '=' case
        //
        outputBuffer[j++] = (char)mk_base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
        outputBuffer[j++] = (char)mk_base64EncodeLookup[((inputBuffer[i] & 0x03) << 4)
                                                        | ((inputBuffer[i + 1] & 0xF0) >> 4)];
        outputBuffer[j++] = (char)mk_base64EncodeLookup[(inputBuffer[i + 1] & 0x0F) << 2];
        outputBuffer[j++] =	'=';
    }
    else if (i < length)
    {
        //
        // Handle the double '=' case
        //
        outputBuffer[j++] = (char)mk_base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
        outputBuffer[j++] = (char)mk_base64EncodeLookup[(inputBuffer[i] & 0x03) << 4];
        outputBuffer[j++] = '=';
        outputBuffer[j++] = '=';
    }
    outputBuffer[j] = 0;
    
    //
    // Set the output length and return the buffer
    //
    if (outputLength)
    {
        *outputLength = j;
    }
    return outputBuffer;
}


//
// dataFromBase64String:
//
// Creates an NSData object containing the base64 decoded representation of
// the base64 string 'aString'
//
// Parameters:
//    aString - the base64 string to decode
//
// returns the autoreleased NSData representation of the base64 string
//
+ (instancetype)mk_dataFromBase64String:(NSString *)aString
{
	NSData *data = [aString dataUsingEncoding:NSASCIIStringEncoding];
	size_t outputLength;
	void *outputBuffer = mk_NewBase64Decode([data bytes], [data length], &outputLength);
	NSData *result = [NSData dataWithBytes:outputBuffer length:outputLength];
	free(outputBuffer);
	return result;
}

//
// base64EncodedString
//
// Creates an NSString object that contains the base 64 encoding of the
// receiver's data. Lines are broken at 64 characters long.
//
// returns an autoreleased NSString being the base 64 representation of the
//	receiver.
//
- (NSString *)mk_base64EncodedString
{
	size_t outputLength = 0;
	char *outputBuffer =
    mk_NewBase64Encode([self bytes], [self length], false, &outputLength);
	
	NSString *result =
    [[NSString alloc]
     initWithBytes:outputBuffer
     length:outputLength
     encoding:NSASCIIStringEncoding];
	free(outputBuffer);
	return result;
}

@end

@implementation NSData (Base64DataExtral)

+ (instancetype)base64DecodeDataFromString:(NSString *)base64String{
    if([self instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)]){
        return [[self alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }else{
        return [self mk_dataFromBase64String:base64String];
    }
}

- (NSString *)base64EncodeString{
    if([self respondsToSelector:@selector(base64EncodedStringWithOptions:)]){
        return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }else{
        return [self mk_base64EncodedString];
    }
}

@end