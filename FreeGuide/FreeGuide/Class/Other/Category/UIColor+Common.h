//
//  UIColor+Common.h
//  TakePlane
//
//  Created by LeeJunHui on 15/4/2.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common)
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
