//
//  FGViewPointInfoViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGViewPointInfoViewController.h"
#import "FGViewPonitTopCell.h"
#import "FGRoutePlaneViewController.h"
#import "FGViewPointInfoDesViewController.h"
@interface FGViewPointInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation FGViewPointInfoViewController

#pragma mark - Life Circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(30, 0, 0, 0)];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        FGViewPonitTopCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ViewPointTop forIndexPath:indexPath];
        cell.viewPoint = self.viewPoint;
        return cell;
    }
    else if(indexPath.section == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = LJHColor(51, 51, 51);
        detailLabel.text = @"景点详情";
        [cell.contentView addSubview:detailLabel];
        
        [detailLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.centerY);
            make.left.equalTo(cell.left).offset(10);
        }];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = LJHColor(51, 51, 51);
        detailLabel.text = @"到这儿去";
        [cell.contentView addSubview:detailLabel];
        
        [detailLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.centerY);
            make.left.equalTo(cell.left).offset(10);
        }];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [FGViewPonitTopCell cellHeight];
    }
    else
    {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1)
    {
        FGViewPointInfoDesViewController *desVC = [[FGViewPointInfoDesViewController alloc] init];
        desVC.content = self.viewPoint.des;
        desVC.title = self.viewPoint.title;
        [self.navigationController pushViewController:desVC animated:YES];
    }
    else if (indexPath.section == 2)
    {
        FGRoutePlaneViewController *routeVC = [[FGRoutePlaneViewController alloc] init];
        routeVC.endCoordinate = CLLocationCoordinate2DMake(self.viewPoint.latitude, self.viewPoint.longitude);
        [self.navigationController pushViewController:routeVC animated:YES];
    }
}

#pragma mark - event response
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private methods
- (void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FGViewPonitTopCell class] forCellReuseIdentifier:kCellIdentifier_ViewPointTop];
    [self.view addSubview:self.tableView];
}

- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

@end
