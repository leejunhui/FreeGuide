//
//  FGViewPonitTopCell.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGViewPoint.h"
#define kCellIdentifier_ViewPointTop @"ViewPonitTopCell"
@interface FGViewPonitTopCell : UITableViewCell
@property (strong, nonatomic) FGViewPoint *viewPoint;
+ (CGFloat)cellHeight;
@end
