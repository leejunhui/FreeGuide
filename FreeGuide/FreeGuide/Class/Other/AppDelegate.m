//
//  AppDelegate.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/5/25.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "FGHomeViewController.h"
#import <iflyMSC/IFlySpeechUtility.h>
#import "FGJingDianViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge |UIUserNotificationTypeSound categories:nil]];
        
    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:253.0/255.0 green:0/255.0 blue:50.0/255.0 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont fontWithName:@"Futura" size:18],
                                  NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self setupMap];
    [self setupIFlyMSC];
    [self setupRootVC];

    
    UILocalNotification *note = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (note) {
        int keyCode = [[note.userInfo valueForKey:@"key"] intValue];
        if (keyCode == 1)
        {
            FGJingDianViewController *vc = [[FGJingDianViewController alloc] init];
            vc.userInfo = note.userInfo;
            [[self.window.rootViewController.childViewControllers firstObject] pushViewController:vc
                                                                                         animated:YES];
        }
    } else {
        
    }
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateActive) return;
    
    int keyCode = [[notification.userInfo valueForKey:@"key"] intValue];
    if (keyCode == 1)
    {
        FGJingDianViewController *vc = [[FGJingDianViewController alloc] init];
        vc.userInfo = notification.userInfo;
        [[[self.window.rootViewController.childViewControllers firstObject] navigationController] pushViewController:vc animated:YES];
    }
    
}

- (void)setupRootVC
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[FGHomeViewController alloc] init]];
}

- (void)setupMap
{
    [MAMapServices sharedServices].apiKey = MAMapKey;
}

- (void)setupIFlyMSC
{
    [IFlySpeechUtility createUtility:IFlyMSCKey];
}

@end
