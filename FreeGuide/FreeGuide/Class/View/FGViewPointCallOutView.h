//
//  FGViewPointCallOutView.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CalloutViewW 280
#define CalloutViewH 120
typedef void (^FGViewPointCallOutViewBlock) ();
@interface FGViewPointCallOutView : UIView
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *des;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) FGViewPointCallOutViewBlock goToDetail;
@end
