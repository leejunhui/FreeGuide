//
//  FGViewPointAnnotation.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
@class FGViewPoint;
@interface FGViewPointAnnotation : MAPointAnnotation
@property (strong, nonatomic) FGViewPoint *viewPoint;
@end