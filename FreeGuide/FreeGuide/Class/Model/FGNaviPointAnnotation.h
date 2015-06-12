//
//  FGNaviPointAnnotation.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

typedef NS_ENUM(NSInteger, NavPointAnnotationType)
{
    NavPointAnnotationStart,
    NavPointAnnotationWay,
    NavPointAnnotationEnd
};

@interface FGNaviPointAnnotation : MAPointAnnotation
@property (nonatomic) enum NavPointAnnotationType navPointType;
@end
