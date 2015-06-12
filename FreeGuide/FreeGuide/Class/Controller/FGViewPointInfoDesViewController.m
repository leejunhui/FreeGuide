//
//  FGViewPointInfoDesViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGViewPointInfoDesViewController.h"

@interface FGViewPointInfoDesViewController ()
@property (strong,nonatomic) UITextView *textView;
@end

@implementation FGViewPointInfoDesViewController

#pragma mark - Life Circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - event response
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private methods
- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}

- (void)setupTextView
{
    self.textView.editable = NO;
    self.textView.alwaysBounceVertical = YES;
    [self.view addSubview:self.textView];
    self.textView.text = self.content;
}

#pragma mark - getters and setters
- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}

@end
