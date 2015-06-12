//
//  FGJingDianViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/5/31.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGJingDianViewController.h"

@interface FGJingDianViewController ()
@property (strong, nonatomic) UITextView *textView;
@end

@implementation FGJingDianViewController

#pragma mark - Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.textColor = LJHColor(102, 102, 102);
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.alwaysBounceVertical = YES;
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    
    [self setupData];
    [self setupNav];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITextViewDelegate

#pragma mark - event response

#pragma mark - private methods



#pragma mark - event response
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods
- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}

- (void)setupData
{
    self.title = self.userInfo[@"title"];
    self.textView.text = self.userInfo[@"body"];
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
