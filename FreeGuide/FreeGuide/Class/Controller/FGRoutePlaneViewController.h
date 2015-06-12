//
//  FGRoutePlaneViewController.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGRoutePlaneViewController : FGBaseViewController<MAMapViewDelegate,AMapSearchDelegate>
@property (assign, nonatomic) CLLocationCoordinate2D endCoordinate;
@end
