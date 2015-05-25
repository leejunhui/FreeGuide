//
//  UIImage+LJH.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LJH)
///**
// *  返回一张图片(自动适配iOS6/7)
// */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  返回一张指定拉伸保护范围的图片
 *
 *  @param name 图片名
 *  @param left 左边的保护范围
 *  @param top  右边的保护范围
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
