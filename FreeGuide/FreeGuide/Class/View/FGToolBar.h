//
//  FGToolBar.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//  底部工具栏

#import <UIKit/UIKit.h>

typedef enum {
    ToolBarButtonTypeNavi,
    ToolBarButtonTypeNear,
    ToolBarButtonTypeService,
    ToolBarButtonTypePersonalInfo
}ToolBarButtonType;

@class FGToolBar;
@class FGToolBarButtonModel;
@protocol FGToolBarDelegate <NSObject>

@optional
/**
 *  底部工具栏按钮被点击代理事件
 *
 *  @param toolBar   工具栏
 *  @param indexPath 按钮位置
 */
- (void)FGToolBar:(FGToolBar *)toolBar DidClickButton:(ToolBarButtonType)buttonType;

@end

@interface FGToolBar : UIView

@property (weak, nonatomic) id<FGToolBarDelegate> delegate;

/**
 *  快速创建一个工具栏
 *
 *  @return 工具栏对象
 */
+ (instancetype)toolBar;


/**
 *  快速创建一个工具栏
 *
 *  @param models 按钮模型
 *
 *  @return 工具栏对象
 */
- (instancetype)initWithButtonModels:(NSArray *)models;

@end
