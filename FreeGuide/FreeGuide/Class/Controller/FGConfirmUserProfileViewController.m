//
//  FGConfirmUserProfileViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/8.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGConfirmUserProfileViewController.h"

@interface FGConfirmUserProfileViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameView;
@property (strong, nonatomic) IBOutlet UITextField *userGenderView;
@property (strong, nonatomic) IBOutlet UITextField *userAgeView;
@property (strong, nonatomic) IBOutlet UITextField *userPassView;
@property (strong, nonatomic) IBOutlet UITextField *userConfirmPassView;
- (IBAction)next;
@end

@implementation FGConfirmUserProfileViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
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
    self.title = @"填写个人资料";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}



- (IBAction)next
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
