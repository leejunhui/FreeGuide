//
//  FGToolBar.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGToolBar.h"
#import "FGToolBarButtonModel.h"
@interface FGToolBar()
@property (strong, nonatomic) NSMutableArray *buttons;
@end
@implementation FGToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (instancetype)toolBar
{
    return [[FGToolBar alloc] init];
}

- (instancetype)initWithButtonModels:(NSArray *)models
{
    if (self = [super init])
    {
        NSInteger buttonCount = models.count;
        
        for (NSInteger index = 0 ; index < buttonCount ; index ++)
        {
            [self addButtonWithButtonModel:models[index]];
        }
        
    }
    return self;
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
 *  @param image 按钮图片
 */
- (void)addButtonWithButtonModel:(FGToolBarButtonModel *)model
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [button setTitleColor:LJHColor(51, 51, 51) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitle:model.title forState:UIControlStateNormal];
    [button setImage:model.image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"default_common_basebutton_background_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"default_common_basebutton_background_highlighted"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:button];
    [self addSubview:button];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.buttons.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    for (NSInteger index = 0; index < self.buttons.count; index ++)
    {
        UIButton *button = self.buttons[index];
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

#pragma mark - Event Response
- (void)buttonClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(FGToolBar:DidClickButton:)])
    {
        NSInteger index = [self.buttons indexOfObject:button];
        [self.delegate FGToolBar:self DidClickButton:(ToolBarButtonType)index];
    }
}

#pragma mark - getters and setters
- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
@end
