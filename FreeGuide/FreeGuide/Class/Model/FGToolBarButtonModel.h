//
//  FGToolBarButtonModel.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGToolBarButtonModel : NSObject
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithTitle:(NSString *)title Image:(UIImage *)image;
@end
