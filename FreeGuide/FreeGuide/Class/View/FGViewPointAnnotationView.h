//
//  FGViewPointAnnotationView.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "FGViewPointCallOutView.h"
#import "FGViewPoint.h"
typedef void (^FGViewPointAnnotationViewBlock) (FGViewPoint *viewPoint);
@interface FGViewPointAnnotationView : MAAnnotationView
@property (readonly, nonatomic) FGViewPointCallOutView *calloutView;
@property (strong, nonatomic) FGViewPoint *viewPoint;
@property (copy, nonatomic) FGViewPointAnnotationViewBlock goToDetail;
@end
