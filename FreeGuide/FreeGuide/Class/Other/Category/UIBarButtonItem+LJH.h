//
//  UIBarButtonItem+LJH.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LJH)
/**
 *  快速创建一个barButtonItem
 *
 *  @param icon     图片
 *  @param highIcon 选中时的图片
 *  @param action   对应的事件
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
