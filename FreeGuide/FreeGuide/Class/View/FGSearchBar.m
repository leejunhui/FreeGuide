//
//  FGSearchBar.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGSearchBar.h"
@interface FGSearchBar()
@property (strong, nonatomic) UIImageView *leftView;
@property (strong, nonatomic) UITextField *inputView;
@end
@implementation FGSearchBar

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftViewX = 5;

    CGFloat leftViewW = _leftView.image.size.width;
    CGFloat leftViewH = _leftView.image.size.height;
    CGFloat leftViewY = (self.frame.size.height - leftViewH) / 2;
    _leftView.frame = CGRectMake(leftViewX, leftViewY, leftViewW, leftViewH);
    
    CGFloat inputViewX = CGRectGetMaxX(_leftView.frame) + 5;
    CGFloat inputViewW = self.frame.size.width - 5 - leftViewW - 5 - 10;
    CGFloat inputViewH = self.frame.size.height;
    CGFloat inputViewY = 0;
    _inputView.frame = CGRectMake(inputViewX, inputViewY, inputViewW, inputViewH);
    

}



#pragma mark - Custom Methods
- (void)setupUI
{
    [self addSubview:self.leftView];
    
    [self addSubview:self.inputView];
    
    [LJHNotificationCenter addObserver:self selector:@selector(textChange) name:UITextFieldTextDidBeginEditingNotification object:self.inputView];
}

- (void)FGSearchBarShouldBeginSearch
{
    [self.inputView becomeFirstResponder];
}

- (void)FGSearchBarShouldEndSearch
{
    [self.inputView resignFirstResponder];
}

- (void)textChange
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(FGSearchBarDidBeginSearch)])
    {
        [self.delegate FGSearchBarDidBeginSearch];
    }
}



#pragma mark - getters and setters
- (UIImageView *)leftView
{
    if (!_leftView)
    {
        _leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_common_searchbtn_image_normal"]];
    }
    return _leftView;
}

- (UITextField *)inputView
{
    if(!_inputView)
    {
        _inputView = [[UITextField alloc] init];
        _inputView.textColor = LJHColor(102, 102, 102);
        _inputView.placeholder = @"查找景区服务";
    }
    return _inputView;
}


- (void)dealloc
{
    [LJHNotificationCenter removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self.inputView];
}
@end
