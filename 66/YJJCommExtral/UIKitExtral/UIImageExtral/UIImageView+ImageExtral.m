//
//  UIImageView+ImageExtral.m
//  BPC-4S-W
//
//  Created by YiJianJun on 14-6-16.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "UIImageView+ImageExtral.h"
//#import "MHFacebookImageViewer.h"
#import "NSData+DataExtral.h"
#import "UIImage+animatedGIF.h"

@implementation UIImageView (ImageExtral)

///单图点击放大
//- (void)addTap2ShowWithURL:(NSURL *)imageURL{
//    if(imageURL){
//        [self setupImageViewerWithImageURL:imageURL];
//    }else{
//        [self setupImageViewer];
//    }
//}

@end

@implementation UIImageView (ImageDataCategroy)

///路径
- (void)setImageWithImagePath:(NSString *)imagePath{
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    [self setImageWithImageData:imageData];
}

///图片地址,不能是本地路径
- (void)setImageWithImageURL:(NSURL *)imageURL{
    
}

///直接设置data
- (void)setImageWithImageData:(NSData *)imageData{
    if(!imageData || !imageData.length){
        return;
    }
    Data_Image_Type type = [imageData dataImageType];
    switch (type) {
        case Data_Image_Type_GIF:
        {
            UIImage *gifImage = [UIImage animatedImageWithAnimatedGIFData:imageData];
            if(gifImage){
                [self setImage:gifImage];
            }
        }
            break;
        case Data_Image_Type_Invaild:
        case Data_Image_Type_Unkown:
            break;
        default:
        {
            UIImage *image = [UIImage imageWithData:imageData];
            if(image){
                [self setImage:image];
            }
        }
            break;
    }
}

@end

@implementation UIImageView (UIImageView_FaceAwareFill)

static CIDetector* _faceDetector;

+ (void)initialize
{
    _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                       context:nil
                                       options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
    
}

// based on this: http://maniacdev.com/2011/11/tutorial-easy-face-detection-with-core-image-in-ios-5/
- (void) faceAwareFill {
    // Safe check!
    if (self.image == nil) {
        return;
    }
    
    CGRect facesRect = [self rectWithFaces];
    if (facesRect.size.height + facesRect.size.width == 0)
        return;
    self.contentMode = UIViewContentModeTopLeft;
    [self scaleImageFocusingOnRect:facesRect];
}

- (CGRect) rectWithFaces {
    // Get a CIIImage
    CIImage* image = self.image.CIImage;
    
    // If now available we create one using the CGImage
    if (!image) {
        image = [CIImage imageWithCGImage:self.image.CGImage];
    }
    
    // Use the static CIDetector
    CIDetector* detector = _faceDetector;
    
    // create an array containing all the detected faces from the detector
    NSArray* features = [detector featuresInImage:image];
    
    // we'll iterate through every detected face. CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.
    CGRect totalFaceRects = CGRectMake(self.image.size.width/2.0, self.image.size.height/2.0, 0, 0);
    
    if (features.count > 0) {
        //We get the CGRect of the first detected face
        totalFaceRects = ((CIFaceFeature*)[features objectAtIndex:0]).bounds;
        
        // Now we find the minimum CGRect that holds all the faces
        for (CIFaceFeature* faceFeature in features) {
            totalFaceRects = CGRectUnion(totalFaceRects, faceFeature.bounds);
        }
    }
    
    //So now we have either a CGRect holding the center of the image or all the faces.
    return totalFaceRects;
}

- (void) scaleImageFocusingOnRect:(CGRect) facesRect {
    CGFloat multi1 = self.frame.size.width / self.image.size.width;
    CGFloat multi2 = self.frame.size.height / self.image.size.height;
    CGFloat multi = MAX(multi1, multi2);
    
    //We need to 'flip' the Y coordinate to make it match the iOS coordinate system one
    facesRect.origin.y = self.image.size.height - facesRect.origin.y - facesRect.size.height;
    
    facesRect = CGRectMake(facesRect.origin.x*multi, facesRect.origin.y*multi, facesRect.size.width*multi, facesRect.size.height*multi);
    
    CGRect imageRect = CGRectZero;
    imageRect.size.width = self.image.size.width * multi;
    imageRect.size.height = self.image.size.height * multi;
    imageRect.origin.x = MIN(0.0, MAX(-facesRect.origin.x + self.frame.size.width/2.0 - facesRect.size.width/2.0, -imageRect.size.width + self.frame.size.width));
    imageRect.origin.y = MIN(0.0, MAX(-facesRect.origin.y + self.frame.size.height/2.0 -facesRect.size.height/2.0, -imageRect.size.height + self.frame.size.height));
    
    imageRect = CGRectIntegral(imageRect);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 2.0);
    [self.image drawInRect:imageRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
    
    //This is to show the red rectangle over the faces
#ifdef DEBUGGING_FACE_AWARE_FILL
    NSInteger theRedRectangleTag = -3312;
    UIView* facesRectLine = [self viewWithTag:theRedRectangleTag];
    if (!facesRectLine) {
        facesRectLine = [[UIView alloc] initWithFrame:facesRect];
        facesRectLine.tag = theRedRectangleTag;
    }
    else {
        facesRectLine.frame = facesRect;
    }
    
    facesRectLine.backgroundColor = [UIColor clearColor];
    facesRectLine.layer.borderColor = [UIColor redColor].CGColor;
    facesRectLine.layer.borderWidth = 4.0;
    
    CGRect frame = facesRectLine.frame;
    frame.origin.x = imageRect.origin.x + frame.origin.x;
    frame.origin.y = imageRect.origin.y + frame.origin.y;
    facesRectLine.frame = frame;
    
    [self addSubview:facesRectLine];
#endif
}

@end

