//
//  NSString+Common.h
//  TakePlane
//
//  Created by LeeJunHui on 15/4/3.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (NSString *)md5Str;

- (BOOL)isEmpty;
@end
