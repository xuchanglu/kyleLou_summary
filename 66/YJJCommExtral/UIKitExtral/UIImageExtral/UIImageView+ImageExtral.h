//
//  UIImageView+ImageExtral.h
//  BPC-4S-W
//
//  Created by YiJianJun on 14-6-16.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ImageExtral)

///单图点击放大
//- (void)addTap2ShowWithURL:(NSURL *)imageURL;

@end

/**
 *该分类根据图片数据辨别gif或其他png,jpg等格式设置
 **/
@interface UIImageView (ImageDataCategroy)

///路径
- (void)setImageWithImagePath:(NSString *)imagePath;
///图片地址,不能是本地路径
- (void)setImageWithImageURL:(NSURL *)imageURL;
///直接设置data
- (void)setImageWithImageData:(NSData *)imageData;

@end

@interface UIImageView (UIImageView_FaceAwareFill)

//Ask the image to perform an "Aspect Fill" but centering the image to the detected faces
//Not the simple center of the image
- (void) faceAwareFill;

@end

NS_ASSUME_NONNULL_END
