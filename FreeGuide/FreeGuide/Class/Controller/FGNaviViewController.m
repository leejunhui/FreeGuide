//
//  FGNaviViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGNaviViewController.h"
#import "FGSearchBar.h"
#import "FGRoutePlaneViewController.h"
@interface FGNaviViewController ()<AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) UITextField *searchBar;
@property (strong, nonatomic) AMapSearchAPI *searchAPI;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *searchResults;
@end

@implementation FGNaviViewController

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
    [self setupTableView];
    LJHLog(@"%@",self.currentCity);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [LJHNotificationCenter addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.searchBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)dealloc
{
    [LJHNotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:self.searchBar];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }

    AMapTip *tip = self.searchResults[indexPath.row];
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.district;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchResults.count)
    {
        AMapTip *tip = self.searchResults[indexPath.row];
        
        //将地理位置转换成经纬度坐标
        
        AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
        request.searchType = AMapSearchType_Geocode;
        request.address = tip.name;
        request.city = @[tip.district];
        
        [self.searchAPI AMapGeocodeSearch:request];
    }
}

#pragma mark - AMapSearchDelegate
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.searchResults removeAllObjects];
    if (response.tips.count == 0)
    {
        [self.tableView reloadData];
        return;
    }
    
    NSString *strtips = @"";
    for (AMapTip *p in response.tips) {
        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
        if (p != nil) {
            [self.searchResults addObject:p];
        }
    }
    [self.tableView reloadData];
//    [self.searchBar resignFirstResponder];
//    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
//    NSLog(@"InputTips: %@", result);
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.count)
    {
        AMapGeocode *geocode = [response.geocodes firstObject];
        AMapGeoPoint *point = geocode.location;
        
        FGRoutePlaneViewController *vc = [[FGRoutePlaneViewController alloc] init];
        vc.endCoordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - event response
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textDidChanged:(NSNotification *)notify
{
    if (self.currentCity)
    {
        //构造AMapInputTipsSearchRequest对象，keywords为必选项，city为可选项
        AMapInputTipsSearchRequest *tipsRequest= [[AMapInputTipsSearchRequest alloc] init];
        tipsRequest.searchType = AMapSearchType_InputTips;
        tipsRequest.keywords = self.searchBar.text;
        tipsRequest.city = @[self.currentCity];
        
        //发起输入提示搜索
        [self.searchAPI AMapInputTipsSearch: tipsRequest];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]])
    {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - private methods
- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}

- (void)setupTableView
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - getters and setters
- (UITextField *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UITextField alloc] init];
        _searchBar.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"请输入目的地";
        _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _searchBar;
}

- (AMapSearchAPI *)searchAPI
{
    if (!_searchAPI)
    {
        _searchAPI = [[AMapSearchAPI alloc] initWithSearchKey:MAMapKey Delegate:self];
    }
    return _searchAPI;
}

- (NSMutableArray *)searchResults
{
    if (!_searchResults)
    {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
