//
//  FGLoginViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/8.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGLoginViewController.h"
#import "FGHomeViewController.h"
#import "FGRegistViewController.h"
#import "FGForgetUserPassViewController.h"
@interface FGLoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameView;
@property (strong, nonatomic) IBOutlet UITextField *userPassView;
@property (strong, nonatomic) IBOutlet UIImageView *userHeadView;


- (IBAction)login;
- (IBAction)regist;
- (IBAction)forget;
@end

@implementation FGLoginViewController

#pragma mark - Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (IBAction)login
{
    if (self.userNameView.text.length == 0)
    {
        [ProgressHUD showError:@"请填写用户名!"];
    }
    else if (self.userPassView.text.length == 0)
    {
        [ProgressHUD showError:@"请填写密码!"];
    }
    else
    {
//        NSDictionary *param = @{@"userName":self.userNameView.text,
//                                @"passWord":self.userPassView.text
//                                };
//        [MSHttpTool getWithURL:@"http://czarl.top/User/Login" params:param success:^(id json){
//            if (json)
//            {
//                if ([json[@"IsSuccess"] boolValue] == YES)
//                {
//                    [ProgressHUD showSuccess:@"登录成功!"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginKey];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    
//                    self.view.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[FGHomeViewController alloc] init]];
//                }
//                else
//                {
//                    NSString *msg = json[@"Message"];
//                    [ProgressHUD showError:msg];
//                }
//            }
//
//        } failure:^(NSError *error) {
//            [ProgressHUD showError:@"网络错误了!"];
//        }];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.view.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[FGHomeViewController alloc] init]];
    }

}

- (IBAction)regist
{
    [self.navigationController pushViewController:[[FGRegistViewController alloc] init] animated:YES];
}

- (IBAction)forget
{
    [self.navigationController pushViewController:[[FGForgetUserPassViewController alloc] init] animated:YES];
}
@end
