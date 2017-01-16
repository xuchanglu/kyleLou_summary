//
//  UIImage+ImageCategory.h
//  BPC-4S-W
//
//  Created by YiJianJun on 14-7-4.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageCategory)

///color to image
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;

///压缩图片大小 最大limitedLength字节) 同步
- (nullable NSData *)compressImageDataWithLimitedLength:(double)limitedLength;
///异步压缩
- (void)compressImageDataWithLimitedLength:(double)limitedLength completion:(void (^)(NSData *compressedData))completion;

///压缩图片大小 最大limitedLength字节) 同步
- (nullable UIImage *)compressImageWithLimitedLength:(double)limitedLength;
///异步压缩
- (void)compressImageWithLimitedLength:(double)limitedLength completion:(void (^)(UIImage *compressedImage))completion;

///iOS将彩色图片转化成黑白图片 type:0~3
- (UIImage *)grayscaleWithType:(int)type;

///纠正图片方向
- (UIImage *)imageFixOrientation;

///截取图片大小
+ (nullable UIImage *)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize;
+ (void)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize completion:(void (^)(UIImage *thumbImage))completion;

///根据视图View生成图片Image
+ (UIImage *)convertViewToImage:(UIView*)v;
@end

@interface UIImage (ThumbImageExtral)
+ (UIImage *)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize;
+ (void)thumbImageHandleByImage:(UIImage *)image size:(CGSize)thumbSize completion:(void (^)(UIImage *thumbImage))completion;
@end

@interface UIImage (ImageResizeExtral)

+ (void)sourceImage:(UIImage *)image maxSize:(CGSize)maxSize completion:(void (^)(UIImage *resizedImage))completion;

@end

@interface UIImage (SaveImage2PhotoLibarayExtral)

typedef void (^ALAssetsLibraryWriteImageCompletionBlock)(NSURL *assetURL, NSError *error);

+ (void)saveImage2PhotoLibaray:(UIImage *)image block:(ALAssetsLibraryWriteImageCompletionBlock)block;

@end

@interface UIImage (FaceFit)

- (UIImage *)faceImageConstrainedToSize:(CGSize)size;
@end

@interface UIImage (GIF)

+(UIImage *)animatedGIFNamed:(NSString*)name;
+(UIImage *)animatedGIFWithData:(NSData *)data;

-(UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end

@interface UIImage (pixelsAdditions)

- (UIColor *)getRGBAatPoint:(CGPoint)point;

@property (readonly) CGPoint whitePoint;

@end

@interface UIImage (Blur)

// 0.0 to 1.0
- (UIImage *)blurredImage:(CGFloat)blurAmount;

@end

@interface UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@interface UIImage (Screenshot)

+ (UIImage *)screenshot;

@end

// Helper methods for adding an alpha layer to an image
@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;
@end

// Extends the UIImage class to support resizing/cropping
@interface UIImage (Resize)
- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
@end

@interface UIImage(ResizeCategory)
-(UIImage *)resizedImageToSize:(CGSize)dstSize;
-(UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
@end

// Extends the UIImage class to support making rounded corners
@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;
@end

NS_ASSUME_NONNULL_END
