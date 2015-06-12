//
//  FGRegistViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/8.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGRegistViewController.h"
#import "FGConfirmUserProfileViewController.h"
@interface FGRegistViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userPhoneView;
@property (strong, nonatomic) IBOutlet UITextField *userCodeView;

@property (strong, nonatomic) IBOutlet UILabel *codeTextView;
- (IBAction)next;
- (IBAction)getCode;
@end

@implementation FGRegistViewController

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
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}

- (IBAction)next
{
    [self.navigationController pushViewController:[[FGConfirmUserProfileViewController alloc] initWithNibName:@"FGConfirmUserProfileViewController" bundle:nil] animated:YES];
}

- (IBAction)getCode
{
    
    
}
@end
