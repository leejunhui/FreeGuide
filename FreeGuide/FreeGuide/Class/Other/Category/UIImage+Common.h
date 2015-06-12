//
//  UIImage+Common.h
//  TakePlane
//
//  Created by LeeJunHui on 15/4/18.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface UIImage (Common)
+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;

@end
