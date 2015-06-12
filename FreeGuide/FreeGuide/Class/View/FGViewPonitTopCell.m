//
//  FGViewPonitTopCell.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGViewPonitTopCell.h"
#import "FGViewPoint.h"
@interface FGViewPonitTopCell()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameView;
@property (strong, nonatomic) UILabel *addressView;
@end

@implementation FGViewPonitTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *iconView = [[UIImageView alloc] init];
    //    iconView.userInteractionEnabled = YES;
    //    [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconTapped)]];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@((200)));
    }];
    
    UIImageView *cover = [[UIImageView alloc] init];
    cover.image = [UIImage imageNamed:@"buy_detail_top_cover"];
    [iconView addSubview:cover];
    
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(iconView);
        make.height.equalTo(@((40)));
    }];
    
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor whiteColor];
    //    portNameLabel.text = self.airLineCompany.name;
    [cover addSubview:nameView];
    self.nameView = nameView;
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cover).offset(10);
        make.centerY.equalTo(cover.mas_centerY);
        make.right.equalTo(cover.mas_right).offset(- 10);
    }];
    
    UIView *locationBGView = [[UIView alloc] init];
    locationBGView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:locationBGView];
    
    [locationBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(iconView.mas_bottom);
        make.height.equalTo(@((40)));
    }];
    
    
    UIImageView *locationIconView = [[UIImageView alloc] init];
    locationIconView.image = [UIImage imageNamed:@"rent_location"];
    [locationBGView addSubview:locationIconView];
    
    [locationIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(locationBGView).offset(10);
    }];
    
    UILabel *addressView = [[UILabel alloc] init];
    addressView.numberOfLines = 0;
    addressView.textColor = LJHColor(102, 102, 102);
    [locationBGView addSubview:addressView];
    addressView.font = [UIFont systemFontOfSize:14];
    self.addressView = addressView;
    
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationIconView.mas_centerY);
        make.left.equalTo(locationIconView.mas_right).offset(10);
        make.width.equalTo(@(250));
    }];
}

- (void)setViewPoint:(FGViewPoint *)viewPoint
{
    _viewPoint = viewPoint;
    
    self.iconView.image = [UIImage imageNamed:_viewPoint.img];
    self.nameView.text = _viewPoint.title;
    self.addressView.text = _viewPoint.address;
}


+ (CGFloat)cellHeight
{
    CGFloat height = 0;
    height += 200;
    height += 40;
    return height;
}
@end
