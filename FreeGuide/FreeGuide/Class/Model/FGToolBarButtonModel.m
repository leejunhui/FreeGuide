//
//  FGToolBarButtonModel.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGToolBarButtonModel.h"

@implementation FGToolBarButtonModel

- (instancetype)initWithTitle:(NSString *)title Image:(UIImage *)image
{
    if (self = [super init])
    {
        self.title = title;
        self.image = image;
    }
    return self;
}
@end
