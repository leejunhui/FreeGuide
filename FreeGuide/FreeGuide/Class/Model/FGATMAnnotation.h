//
//  FGATMAnnotation.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "FGATM.h"
@interface FGATMAnnotation : MAPointAnnotation
@property (strong, nonatomic) FGATM *atm;
@end
