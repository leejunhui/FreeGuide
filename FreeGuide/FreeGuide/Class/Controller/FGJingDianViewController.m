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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTextView];
    [self setupData];
}

- (void)setupTextView
{
    UITextView *textView = [[UITextView alloc] init];
    textView.textColor = LJHColor(102, 102, 102);
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupData
{
    self.title = self.userInfo[@"title"];
    self.textView.text = self.userInfo[@"body"];
}

@end
