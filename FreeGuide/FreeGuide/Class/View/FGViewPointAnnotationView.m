//
//  FGViewPointAnnotationView.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGViewPointAnnotationView.h"
#import "FGViewPointCallOutView.h"
#import "FGViewPointAnnotation.h"
@interface FGViewPointAnnotationView()
@property (strong, nonatomic, readwrite) FGViewPointCallOutView *calloutView;
@end
@implementation FGViewPointAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected)
    {
        return;
    }
    if (selected)
    {
        FGViewPointAnnotation *annotation = (FGViewPointAnnotation *)self.annotation;
        //        if ([annotation.shop.category_name isEqualToString:@"美食"])
        //        {
        //            self.image = [UIImage imageNamed:@"food_callout"];
        //        }
        //        else if ([annotation.shop.category_name isEqualToString:@"小吃"])
        //        {
        //            self.image = [UIImage imageNamed:@"snack_callout"];
        //        }
        //        else if ([annotation.shop.category_name isEqualToString:@"购物"])
        //        {
        //            self.image = [UIImage imageNamed:@"shopping_callout"];
        //        }
        //        else if ([annotation.shop.category_name isEqualToString:@"生活服务"])
        //        {
        //            self.image = [UIImage imageNamed:@"service_callout"];
        //        }
        //        else if ([annotation.shop.category_name isEqualToString:@"旅游"])
        //        {
        //            self.image = [UIImage imageNamed:@"travel_callout"];
        //        }
        //        else if ([annotation.shop.category_name isEqualToString:@"休闲娱乐"])
        //        {
        //            self.image = [UIImage imageNamed:@"entertainment_callout"];
        //        }
        if (self.calloutView == nil)
        {
            self.calloutView = [[FGViewPointCallOutView alloc] initWithFrame:CGRectZero];
            self.calloutView.frame = CGRectMake(0, 0, CalloutViewW, CalloutViewH);
            
            __weak typeof(self) weakSelf = self;
            self.calloutView.goToDetail = ^{
                if (weakSelf.goToDetail)
                {
                    FGViewPointAnnotation *annotation = (FGViewPointAnnotation *)weakSelf.annotation;
                    weakSelf.goToDetail(annotation.viewPoint);
                }
            };
            
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f +
                                                  self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        self.calloutView.img = annotation.viewPoint.img;
        self.calloutView.name = annotation.viewPoint.title;
        self.calloutView.des = annotation.viewPoint.address;
        [self addSubview:self.calloutView];
        self.image = [UIImage imageNamed:@"map_annotation_selected"];
    }
    
    else
    {
        self.image = [UIImage imageNamed:@"map_annotation"];
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

@end
