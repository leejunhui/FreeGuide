//
//  FGViewPoint.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGViewPoint : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *des;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;
@end
