//
//  FGOrderTicketViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGOrderTicketViewController.h"

@interface FGOrderTicketViewController ()

@end

@implementation FGOrderTicketViewController

#pragma mark - Life Circle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
}

#pragma mark -

#pragma mark - event response
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - private methods
- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"订票";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}

#pragma mark - getters and setters


@end
