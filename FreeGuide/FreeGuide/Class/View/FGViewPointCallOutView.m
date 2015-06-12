//
//  FGViewPointCallOutView.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGViewPointCallOutView.h"

@interface FGViewPointCallOutView()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UIImageView *bgView;
@property (strong, nonatomic) UILabel *nameView;
@property (strong, nonatomic) UILabel *phoneView;
@property (strong, nonatomic) UIButton *desButton;
@end

@implementation FGViewPointCallOutView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_callout_bg"]];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)]];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    self.bgView = bgView;
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [bgView addSubview:iconView];
    self.iconView = iconView;
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.bgView).offset(10);
        make.height.equalTo(@(85));
        make.width.equalTo(@(130));
    }];
    
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = [UIFont systemFontOfSize:14];
    nameView.textColor = LJHColor(102, 102, 102);
    [bgView addSubview:nameView];
    self.nameView = nameView;
    
    [self.nameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.top);
        make.left.equalTo(self.iconView.right).offset(10);
        make.right.equalTo(self.bgView.right).offset(- 10);
    }];
    
    UILabel *phoneView = [[UILabel alloc] init];
    phoneView.font = [UIFont systemFontOfSize:14];
    phoneView.textColor = LJHColor(102, 102, 102);
    [bgView addSubview:phoneView];
    self.phoneView = phoneView;
    
    [self.phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView.bottom);
        make.left.equalTo(self.nameView.left);
        make.right.equalTo(self.nameView.right);
    }];
    
    UIButton *desButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [desButton setBackgroundImage:[UIImage imageNamed:@"share_cell_arrow"] forState:UIControlStateNormal];
    [desButton addTarget:self action:@selector(goToDetailClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:desButton];
    self.desButton = desButton;
    
    [self.desButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.right).offset(- 10);
        make.centerY.equalTo(self.bgView.centerY);
    }];
}

- (void)setImg:(NSString *)img
{
    _img = [img copy];
    self.iconView.image = [UIImage imageNamed:_img];
}

- (void)setDes:(NSString *)des
{
    _des = [des copy];
    self.phoneView.text = _des;
}


- (void)setName:(NSString *)name
{
    _name = [name copy];
    self.nameView.text = name;
}

- (void)goToDetailClick
{
    if(_goToDetail)
    {
        _goToDetail();
    }
}

- (void)tapped
{
    if(_goToDetail)
    {
        _goToDetail();
    }
}

@end
