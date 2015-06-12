//
//  FGNotifyImageAndTextViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGNotifyImageAndTextViewController.h"

@implementation FGNotifyImageAndTextViewController

#pragma mark - Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    self.title = @"青城山欢迎您";
}

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

@end
