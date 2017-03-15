//
//  UIImage+APAddition.h
//  Etion
//
//  Created by  user on 11-9-5.
//  Copyright 2011 GuangZhouXuanWu. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface UIImage (UIImageExtend)

typedef enum
{
    EImageFillStyleNone,                    //不做任何改变，只在相应区域显示
    EImageFillStyleStretch,                 //进行拉伸，填充整个显示区域
    EImageFillStyleScale,                   //按照图片尺寸比例进行缩放，在显示区域中显示出整张图片
    EImageFillStyleStretchByScale,          //按照图片尺寸比例进行缩放，填充整个显示区域
    EImageFillStyleStretchByXCenterScale,   //按照图片尺寸比例进行缩放，填充整个显示区域，并且X居中
    EImageFillStyleStretchByCenterScale     //按照图片尺寸比例进行缩放，填充整个显示区域，并且居中
} EImageFillStyle;

- (UIImage *)imageByResizeToSize:(CGSize)size;

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;

+ (UIImage *)imageWithContentsOfResolutionIndependentFile:(NSString *)path;

+ (UIImage *)imageFromImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)imageFromImage:(UIImage *)image scaledToFitSize:(CGSize)newSize;

+ (UIImage *)imageFromImage:(UIImage *)image size:(CGSize)newSize fillStyle:(EImageFillStyle)fillStyle;

+ (UIImage *)imageFromImage:(UIImage *)image maxSize:(CGSize)maxSize minSize:(CGSize)minSize;

+ (CGSize)imageNewSizeFromImageSize:(CGSize)imageSize maxSize:(CGSize)maxSize minSize:(CGSize)minSize;

+ (CGFloat)caleFitImageSize:(CGSize)oriimgsize targetSize:(CGSize)targetimgsize width:(CGFloat *)nInitwidth height:(CGFloat *)nInitheight;

+ (CGSize)caleFitImageSize:(CGSize)orgSize targetSize:(CGSize)targetSize;

- (UIImage *)resizeableCenterImage;

- (UIImage *)drawResizeableImageWithSize:(CGSize)size capInsets:(UIEdgeInsets)capinsets;

+ (UIImage *)imageFromImage:(UIImage *)image renderWithColor:(UIColor *)renderColor;


@end


