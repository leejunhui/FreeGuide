//
//  FGForgetUserPassViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/8.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGForgetUserPassViewController.h"
#import "FGResetUserPassViewController.h"
@interface FGForgetUserPassViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userPhoneView;
@property (strong, nonatomic) IBOutlet UITextField *userCodeView;
@property (strong, nonatomic) IBOutlet UILabel *codeTextView;
- (IBAction)next;

- (IBAction)getCode;
@end

@implementation FGForgetUserPassViewController

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
    self.title = @"忘记密码";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}



- (IBAction)next
{
    [self.navigationController pushViewController:[[FGResetUserPassViewController alloc] initWithNibName:@"FGResetUserPassViewController" bundle:nil] animated:YES];
}

- (IBAction)getCode
{
    
}
@end
