//
//  FGSearchViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGSearchViewController.h"
#import "FGSearchBar.h"
@interface FGSearchViewController ()
@property (strong, nonatomic) UITextField *searchBar;
@end

@implementation FGSearchViewController

#pragma mark - Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}



#pragma mark - Custom Delegate

#pragma mark - event response
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods
- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}


#pragma mark - getters and setters
- (UITextField *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UITextField alloc] init];
        _searchBar.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"搜素";
    }
    return _searchBar;
}


@end
