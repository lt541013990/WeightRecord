//
//  UIImage+APAddition.m
//  Etion
//
//  Created by  user on 11-9-5.
//  Copyright 2011 GuangZhouXuanWu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UIImageExtend.h"

@implementation UIImage (UIImageExtend)

- (UIImage *)imageByResizeToSize:(CGSize)size{
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path
{
    if ([[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] == 2.0)
    {
        return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path]] CGImage] scale:2.0 orientation:UIImageOrientationUp];
    }
    return [self initWithData:[NSData dataWithContentsOfFile:path]];
}

+ (UIImage *)imageWithContentsOfResolutionIndependentFile:(NSString *)path
{
    return [[UIImage alloc] initWithContentsOfResolutionIndependentFile:path];
}

+ (UIImage *)imageFromImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageFromImage:(UIImage *)image scaledToFitSize:(CGSize)newSize
{
    CGFloat w = 0, h = 0;
    [UIImage caleFitImageSize:image.size targetSize:newSize width:&w height:&h];
    return [UIImage imageFromImage:image size:CGSizeMake(w, h) fillStyle:EImageFillStyleStretch];
}

+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)newSize fillStyle:(EImageFillStyle)fillStyle
{
    if (image.size.width == newSize.width && image.size.height == newSize.height)
    {
        return image;
    }

    CGSize newImageSize;
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);

    switch (fillStyle)
    {
        case EImageFillStyleStretch:
        {
            [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            break;
        }
        case EImageFillStyleScale:
        {
            [UIImage caleFitImageSize:image.size targetSize:newSize width:&newImageSize.width height:&newImageSize.height];
            [image drawInRect:CGRectMake((newSize.width - newImageSize.width) / 2, (newSize.height - newImageSize.height) / 2, newImageSize.width, newImageSize.height)];
            break;
        }
        case EImageFillStyleStretchByScale:
        case EImageFillStyleStretchByXCenterScale:
        case EImageFillStyleStretchByCenterScale:
        {
            CGFloat rateW = image.size.width / newSize.width;
            CGFloat rateH = image.size.height / newSize.height;
            CGFloat rateScale = rateW < rateH ? 1.0 / rateW : 1.0 / rateH;
            newImageSize.width = rateScale * image.size.width;
            newImageSize.height = rateScale * image.size.height;

            switch (fillStyle)
            {
                case EImageFillStyleStretchByScale:
                    [image drawInRect:CGRectMake(0, 0, newImageSize.width, newImageSize.height)];
                    break;
                case EImageFillStyleStretchByXCenterScale:
                    [image drawInRect:CGRectMake(newImageSize.width > newSize.width ? (newSize.width - newImageSize.width) / 2 : 0, 0, newImageSize.width, newImageSize.height)];
                    break;
                case EImageFillStyleStretchByCenterScale:
                    [image drawInRect:CGRectMake(newImageSize.width > newSize.width ? (newSize.width - newImageSize.width) / 2 : 0, newImageSize.height > newSize.height ? (newSize.height - newImageSize.height) / 2 : 0, newImageSize.width, newImageSize.height)];
                    break;
                default:
                    break;
            }

            break;
        }
        default:
            [image drawAtPoint:CGPointMake(0, 0)];
            break;
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (CGSize)imageNewSizeFromImageSize:(CGSize)imageSize maxSize:(CGSize)maxSize minSize:(CGSize)minSize
{
    //原始图片高宽
    CGFloat picHeight = imageSize.height;
    CGFloat picWidth = imageSize.width;
    
    //界面显示高宽
    CGFloat realHeigth = 0;
    CGFloat realWidth = 0;
    
    //界面可显示的图片高宽最大最小值
    CGFloat minHeigth = minSize.height;
    CGFloat minWidth = minSize.width;
    CGFloat maxHeigth = maxSize.height;
    CGFloat maxWidth = maxSize.width;
    
    //长图
    if(picHeight >= picWidth)
    {
        if(picHeight < minHeigth)
        {
            realHeigth = minHeigth;
            realWidth = picWidth * (minHeigth/picHeight);
        }
        else if(picHeight > maxHeigth)
        {
            realHeigth = maxHeigth;
            realWidth = picWidth * (maxHeigth /picHeight);
        }
        else
        {
            realHeigth = picHeight;
            realWidth = picWidth;
        }
    }
    else
    {
        if(picWidth < minWidth)
        {
            realHeigth = picHeight * (minWidth/picWidth);
            realWidth = minWidth;
        }
        else if(picWidth > maxWidth)
        {
            realHeigth = picHeight * (maxWidth/picWidth);
            realWidth = maxWidth;
        }
        else
        {
            realHeigth = picHeight;
            realWidth = picWidth;
        }
    }
    
    return CGSizeMake(realWidth, realHeigth);
}

+ (UIImage *)imageFromImage:(UIImage *)image maxSize:(CGSize)maxSize minSize:(CGSize)minSize
{
    CGSize newSize = [UIImage imageNewSizeFromImageSize:image.size maxSize:maxSize minSize:minSize];
    
    if(newSize.width == image.size.width && newSize.height == image.size.height)
        return image;
    
    return [UIImage imageFromImage:image scaledToSize:newSize];
}

//get a screenshot


+ (CGFloat)caleFitImageSize:(CGSize)oriimgsize targetSize:(CGSize)targetimgsize width:(CGFloat *)nInitwidth height:(CGFloat *)nInitheight
{
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    CGFloat wmul = 0.0;
    CGFloat hmul = 0.0;
    CGFloat mul = 1.0;
    CGFloat w = targetimgsize.width;
    CGFloat h = targetimgsize.height;
    CGSize imgsize = oriimgsize;
    if (imgsize.width > w)
        mul = wmul = w / imgsize.width;
    if (imgsize.height > h)
        mul = hmul = h / imgsize.height;
    if (wmul != 0.0 && 0.0 == hmul)
    {
        width = w;
        height = imgsize.height * wmul;
    }
    else if (0.0 == wmul && hmul != 0.0)
    {
        width = imgsize.width * hmul;
        height = h;
    }
    else if (0.0 != wmul && 0.0 != hmul)
    {
        mul = MIN(wmul, hmul);
        width = imgsize.width * mul;
        height = imgsize.height * mul;
    }
    else
    {
        width = imgsize.width;
        height = imgsize.height;
    }
    *nInitwidth = width;
    *nInitheight = height;

    return mul;
}

+ (CGSize)caleFitImageSize:(CGSize)orgSize targetSize:(CGSize)targetSize
{
    CGSize fitSize;
    [self caleFitImageSize:orgSize targetSize:targetSize width:&fitSize.width height:&fitSize.height];
    return fitSize;
}

- (UIImage *)resizeableCenterImage
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(self.size.height/2, self.size.width/2, self.size.height/2, self.size.width/2);
    return [self resizableImageWithCapInsets:edgeInsets];
}

- (UIImage *)drawResizeableImageWithSize:(CGSize)size capInsets:(UIEdgeInsets)capinsets
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height),NO, 0);
    
    UIImage* image = [self resizableImageWithCapInsets:capinsets];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)saveImageToPath:(NSString*)path inNewSize:(CGSize)newSize andJPEGCompressionQuality:(CGFloat)compressionQuality completion:(void(^)(BOOL bResult,UIImage *newImage,NSData *newImageData))completion
    {
        UIImage *newImage = self;
        if(newSize.width!=0.0||newSize.height!=0.0)
            newImage = [UIImage imageFromImage:self scaledToSize:newSize];
        NSData *data = UIImageJPEGRepresentation(newImage,compressionQuality);
        BOOL bResult = [data writeToFile:path atomically:NO];
    if(completion != NULL)
        completion(bResult,newImage,data);
}


+ (UIImage *)imageFromImage:(UIImage *)image renderWithColor:(UIColor *)renderColor
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, image.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [image drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [renderColor CGColor]);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceIn);
    CGContextFillRect(ctx, imageRect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *renderImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return renderImage;
}



@end
