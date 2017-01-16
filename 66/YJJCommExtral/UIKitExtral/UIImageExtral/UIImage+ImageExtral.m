//
//  UIImage+ImageCategory.m
//  BPC-4S-W
//
//  Created by YiJianJun on 14-7-4.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "UIImage+ImageExtral.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (ImageCategory)

///color to image
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize{
    CGRect rect = CGRectMake(0, 0, imageSize.width,imageSize.height);
    
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

///压缩图片大小 最大limitedLength(字节)
- (NSData *)compressImageDataWithLimitedLength:(double)limitedLength{
    if(limitedLength <= 1e-6){
        return nil;
    }
    
    NSData *imgData = UIImageJPEGRepresentation(self, 1.0f);
    
    double imageDataLength = imgData.length;
    
    if(fabs(limitedLength - imageDataLength) <= 1e-6 && imageDataLength <= limitedLength){
        ///图片已经小于limitedLength,直接返回
        return imgData;
    }
    
    ///压缩比
    double scale = limitedLength/imageDataLength;
    NSData *compressedData = UIImageJPEGRepresentation(self, scale);
    return compressedData;
}

///异步压缩
- (void)compressImageDataWithLimitedLength:(double)limitedLength completion:(void (^)(NSData *compressedData))completion{
    if(!completion){
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *compressedData = [self compressImageDataWithLimitedLength:limitedLength];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(compressedData);
        });
    });
}

///压缩图片大小 最大limitedLength字节) 同步
- (UIImage *)compressImageWithLimitedLength:(double)limitedLength{
    NSData *compressData = [self compressImageDataWithLimitedLength:limitedLength];
    if(compressData){
        UIImage *compressImg = [UIImage imageWithData:compressData];
        return compressImg;
    }
    return nil;
}

///异步压缩
- (void)compressImageWithLimitedLength:(double)limitedLength completion:(void (^)(UIImage *compressedImage))completion{
    if(!completion){
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *compressedImage = [self compressImageWithLimitedLength:limitedLength];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(compressedImage);
        });
    });
}

///iOS将彩色图片转化成黑白图片
- (UIImage *)grayscaleWithType:(int)type{
    CGImageRef imageRef = self.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case 2:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case 3:
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
    
}

+ (UIImage *)imageFixOrientationWithSrcImg:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)imageFixOrientation{
    return [UIImage imageFixOrientationWithSrcImg:self];
}


+ (UIImage *)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize{
    if(!image){
        return nil;
    }
    UIGraphicsBeginImageContext(thumbSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, thumbSize.width, thumbSize.height);
    [image drawInRect:imageRect];
    UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnailImage;
}

+ (void)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize completion:(void (^)(UIImage *thumbImage))completion{
    if(!image || !completion){
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *thumbnailImage = [self thumbImageHandleByImage:image size:thumbSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(thumbnailImage);
        });
    });
}

+ (UIImage *)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIImage (ThumbImageExtral)

+ (instancetype)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize{
    if(!image){
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(thumbSize, NO, 0.0f);
    CGRect imageRect = CGRectMake(0.0, 0.0, thumbSize.width, thumbSize.height);
    [image drawInRect:imageRect];
    UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnailImage;
}

+ (void)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize completion:(void (^)(UIImage *thumbImage))completion{
    if(!image || !completion){
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(thumbSize, NO, 0.0f);
        CGRect imageRect = CGRectMake(0.0, 0.0, thumbSize.width, thumbSize.height);
        [image drawInRect:imageRect];
        UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        completion(thumbnailImage);
    });
}

@end

@implementation UIImage (ImageResizeExtral)

+ (void)sourceImage:(UIImage *)image maxSize:(CGSize)maxSize completion:(void (^)(UIImage *resizedImage))completion{
    if(!image || !completion){
        return;
    }
    CGSize fixedSize;
    CGSize imageSize = image.size;
    if(imageSize.height > imageSize.width){
        fixedSize = CGSizeMake(maxSize.height, imageSize.width * imageSize.height / maxSize.height);
    }else{
        fixedSize = CGSizeMake(imageSize.height * imageSize.width / maxSize.width, maxSize.width);
    }
    [self thumbImageHandleByImage:image size:fixedSize completion:^(UIImage *thumbImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(thumbImage);
        });
    }];
}

@end

@implementation UIImage (SaveImage2PhotoLibarayExtral)

+ (void)saveImage2PhotoLibaray:(UIImage *)image block:(ALAssetsLibraryWriteImageCompletionBlock)block{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error){
        if(block){
            block(assetURL,error);
        }
    }];
}

@end

@implementation UIImage (FaceFit)

- (CGRect)frameToClip:(CGSize)viewSize {
    CGSize imageSize = self.size;
    if (viewSize.width / viewSize.height > imageSize.width / imageSize.height) {
        // wider
        CGFloat newImageHeight = viewSize.height * imageSize.width / viewSize.width;
        return CGRectMake(0, (imageSize.height - newImageHeight)/2, imageSize.width, newImageHeight);
    } else {
        CGFloat newImageWidth = viewSize.width * imageSize.height / viewSize.height;
        return CGRectMake((imageSize.width - newImageWidth)/2, 0, newImageWidth, imageSize.height);
    }
}


- (instancetype)faceImageConstrainedToSize:(CGSize)viewSize {
    CIImage * ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    NSArray * features = [detector featuresInImage:ciImage];
    CGFloat maxSize = 0;
    CGRect faceBounds;
    for (CIFaceFeature * feature in features) {
        CGRect bounds = feature.bounds;
        // or use the UIImage wherever you like
        if (maxSize < bounds.size.width * bounds.size.height) {
            maxSize = bounds.size.width * bounds.size.height;
            faceBounds = CGRectMake(bounds.origin.x, self.size.height - bounds.origin.y - bounds.size.height, bounds.size.width, bounds.size.height);
        }
    }
    if (maxSize <= 0) {
        return self;
    }
    CGPoint faceCenter = CGPointMake((faceBounds.origin.x + faceBounds.size.width)/2,
                                     (faceBounds.origin.y + faceBounds.size.height)/2);
    CGPoint startCenter = CGPointMake(self.size.width/2, self.size.height/2);
    CGRect clipedFrame = [self frameToClip:viewSize];
    CGPoint origin = clipedFrame.origin;
    CGSize clipedRange = CGSizeMake(fabs(origin.x), fabs(origin.y));
    CGPoint vector = CGPointMake(faceCenter.x - startCenter.x, faceCenter.y - startCenter.y);
    CGPoint offset = CGPointMake(MIN(MAX(-clipedRange.width, vector.x), clipedRange.width),
                                 MIN(MAX(-clipedRange.height, vector.y), clipedRange.height));
    clipedFrame = CGRectMake(clipedFrame.origin.x + offset.x, clipedFrame.origin.y + offset.y, clipedFrame.size.width, clipedFrame.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], clipedFrame);
    UIImage * tImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return tImage;
}

@end

@implementation UIImage (GIF)

+(instancetype)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray* images = [NSMutableArray array];
    
    NSTimeInterval duration = 0.0f;
    
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        NSDictionary* frameProperties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, i, NULL));
        duration += [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
        
        [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
        
        CGImageRelease(image);
    }
    
    CFRelease(source);
    
    if (!duration) {
        duration = (1.0f/10.0f)*count;
    }
    
    return [UIImage animatedImageWithImages:images duration:duration];
}

+(UIImage *)animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString* retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData* data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

-(UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor :heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    } else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray* scaledImages = [NSMutableArray array];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    for (UIImage* image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
    }
    
    UIGraphicsEndImageContext();
    
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

@end

@implementation UIImage (pixelsAdditions)

- (UIColor *)getRGBAatPoint:(CGPoint)point {
    
    UIColor *result = nil;
    
    // First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    byteIndex += 4;
    
    result =  [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    free(rawData);
    
    return result;
}

- (CGPoint)whitePoint {
    
    int kWidth   = self.size.width;
    int kHeight  = self.size.height;
    
    CGPoint     whiteP      = CGPointZero;
    CGFloat     whitAdd     = 0.0; /// Highest would be  3.0 * 255.0;
    
    // First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    for (int x = 0; x < kWidth; x++) {
        for (int y = 0; y < kHeight; y++) {
            CGPoint checkPoint = CGPointMake(x, y);
            
            // Now your rawData contains the image data in the RGBA8888 pixel format.
            int byteIndex = (bytesPerRow * checkPoint.y) + checkPoint.x * bytesPerPixel;
            
            CGFloat red   = (rawData[byteIndex]     * 1.0);
            CGFloat green = (rawData[byteIndex + 1] * 1.0);
            CGFloat blue  = (rawData[byteIndex + 2] * 1.0);
            CGFloat alpha = (rawData[byteIndex + 3] * 1.0);
            byteIndex += 4;
            
            CGFloat total = (red + green + blue)*alpha;
            
            if (total > whitAdd) {
                whitAdd = total;
                whiteP = checkPoint;
            }
        }
    }
    
    free(rawData);
    
    return whiteP;
}

@end

@implementation UIImage (Blur)

- (UIImage *)blurredImage:(CGFloat)blurAmount
{
    if (blurAmount < 0.0 || blurAmount > 1.0) {
        blurAmount = 0.5;
    }
    
    int boxSize = (int)(blurAmount * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (!error) {
            error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        }
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end

@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIImage (Screenshot)

+ (UIImage *)screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
@implementation UIImage (Alpha)

// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha {
    if ([self hasAlpha]) {
        return self;
    }
    
    CGFloat scale = MAX(self.scale, 1.0f);
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef)*scale;
    size_t height = CGImageGetHeight(imageRef)*scale;
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha scale:self.scale orientation:UIImageOrientationUp];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

// Returns a copy of the image with a transparent border of the given size added around its edges.
// If the image has no alpha layer, one will be added to it.
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    CGFloat scale = MAX(self.scale, 1.0f);
    NSUInteger scaledBorderSize = borderSize * scale;
    CGRect newRect = CGRectMake(0, 0, image.size.width * scale + scaledBorderSize * 2, image.size.height * scale + scaledBorderSize * 2);
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));
    
    // Draw the image in the center of the context, leaving a gap around the edges
    CGRect imageLocation = CGRectMake(scaledBorderSize, scaledBorderSize, image.size.width*scale, image.size.height*scale);
    CGContextDrawImage(bitmap, imageLocation, self.CGImage);
    CGImageRef borderImageRef = CGBitmapContextCreateImage(bitmap);
    
    // Create a mask to make the border transparent, and combine it with the image
    CGImageRef maskImageRef = [self newBorderMask:scaledBorderSize size:newRect.size];
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef scale:self.scale orientation:UIImageOrientationUp];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

#pragma mark -
#pragma mark Private helper methods

// Creates a mask that makes the outer edges transparent and everything else opaque
// The size must include the entire mask (opaque part + transparent border)
// The caller is responsible for releasing the returned reference by calling CGImageRelease
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Build a context that's the same dimensions as the new size
    CGContextRef maskContext = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     8, // 8-bit grayscale
                                                     0,
                                                     colorSpace,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    // Start with a mask that's entirely transparent
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    // Make the inner part (within the border) opaque
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    // Get an image of the context
    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);
    
    // Clean up
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

@end

@implementation UIImage (Resize)

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
    CGFloat scale = MAX(self.scale, 1.0f);
    CGRect scaledBounds = CGRectMake(bounds.origin.x * scale, bounds.origin.y * scale, bounds.size.width * scale, bounds.size.height * scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], scaledBounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;
    
    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    switch ( self.imageOrientation )
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
        default:
            drawTransposed = NO;
    }
    
    CGAffineTransform transform = [self transformForOrientation:newSize];
    
    return [self resizedImage:newSize transform:transform drawTransposed:drawTransposed interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat scale = MAX(1.0f, self.scale);
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width*scale, newSize.height*scale));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Fix for a colorspace / transparency issue that affects some types of
    // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                8, /* bits per channel */
                                                (newRect.size.width * 4), /* 4 channels per pixel * numPixels/row */
                                                colorSpace,
                                                kCGImageAlphaPremultipliedLast
                                                );
    CGColorSpaceRelease(colorSpace);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:self.scale orientation:UIImageOrientationUp];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

@end

@implementation UIImage (ResizeCategory)

-(UIImage *)resizedImageToSize:(CGSize)dstSize
{
    CGImageRef imgRef = self.CGImage;
    // the below values are regardless of orientation : for UIImages from Camera, width>height (landscape)
    CGSize  srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which is dependant on the imageOrientation)!
    
    /* Don't resize if we already meet the required destination size. */
    if (CGSizeEqualToSize(srcSize, dstSize)) {
        return self;
    }
    
    CGFloat scaleRatio = dstSize.width / srcSize.width;
    UIImageOrientation orient = self.imageOrientation;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    /////////////////////////////////////////////////////////////////////////////
    // The actual resize: draw the image on a new context, applying a transform matrix
    UIGraphicsBeginImageContextWithOptions(dstSize, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -srcSize.height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -srcSize.height);
    }
    
    CGContextConcatCTM(context, transform);
    
    // we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}



/////////////////////////////////////////////////////////////////////////////



-(UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
{
    // get the image size (independant of imageOrientation)
    CGImageRef imgRef = self.CGImage;
    CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which depends on the imageOrientation)!
    
    // adjust boundingSize to make it independant on imageOrientation too for farther computations
    UIImageOrientation orient = self.imageOrientation;
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            boundingSize = CGSizeMake(boundingSize.height, boundingSize.width);
            break;
        default:
            // NOP
            break;
    }
    
    // Compute the target CGRect in order to keep aspect-ratio
    CGSize dstSize;
    
    if ( !scale && (srcSize.width < boundingSize.width) && (srcSize.height < boundingSize.height) ) {
        //NSLog(@"Image is smaller, and we asked not to scale it in this case (scaleIfSmaller:NO)");
        dstSize = srcSize; // no resize (we could directly return 'self' here, but we draw the image anyway to take image orientation into account)
    } else {
        CGFloat wRatio = boundingSize.width / srcSize.width;
        CGFloat hRatio = boundingSize.height / srcSize.height;
        
        if (wRatio < hRatio) {
            //NSLog(@"Width imposed, Height scaled ; ratio = %f",wRatio);
            dstSize = CGSizeMake(boundingSize.width, floorf(srcSize.height * wRatio));
        } else {
            //NSLog(@"Height imposed, Width scaled ; ratio = %f",hRatio);
            dstSize = CGSizeMake(floorf(srcSize.width * hRatio), boundingSize.height);
        }
    }
    
    return [self resizedImageToSize:dstSize];
}

@end

@implementation UIImage (RoundedCorner)

// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    CGFloat scale = MAX(self.scale,1.0f);
    NSUInteger scaledBorderSize = borderSize * scale;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width*scale,
                                                 image.size.height*scale,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // Create a clipping path with rounded corners
    
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(scaledBorderSize, scaledBorderSize, image.size.width*scale - borderSize * 2, image.size.height*scale - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize*scale
                    ovalHeight:cornerSize*scale];
    CGContextClosePath(context);
    CGContextClip(context);
    
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width*scale, image.size.height*scale), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage scale:self.scale orientation:UIImageOrientationUp];
    
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@end
