//
//  FGRoutePlaneViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/7.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGRoutePlaneViewController.h"
#import "FGNaviPointAnnotation.h"
#import "FGNavPointAnnotationView.h"
@interface FGRoutePlaneViewController ()
@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) AMapSearchAPI *searchApi;
@property (nonatomic) BOOL calRouteSuccess; // 指示是否算路成功
@property (nonatomic, strong) NSMutableArray *annotations;
@property (assign, nonatomic) CLLocationCoordinate2D startCoordinate;
@property (strong, nonatomic) NSArray *pathPolylines;
@property (strong, nonatomic) FGNaviPointAnnotation *endPointAnnotation;
@property (strong, nonatomic) FGNaviPointAnnotation *startPointAnnotation;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (assign, nonatomic) AMapSearchType routeSearchType;
@end

@implementation FGRoutePlaneViewController

#pragma mark - 懒加载
- (NSMutableArray *)annotations
{
    if (!_annotations)
    {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

#pragma mark - Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"到这儿去";
    self.routeSearchType = AMapSearchType_NaviWalking;
    [ProgressHUD show:@"加载中..."];
    [self setupMap];
    [self setupSearchApi];
    [self setupNav];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_panorama_bar_menu_normal" highIcon:@"default_panorama_bar_menu_normal" target:self action:@selector(switchRoute)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchRoute
{
    int selectedIndex = self.routeSearchType == AMapSearchType_NaviDrive;
    [SGActionView showSheetWithTitle:@"选择出行方式" itemTitles:@[@"步行",@"驾车"] selectedIndex:selectedIndex selectedHandle:^(NSInteger index) {
        if (index == 0)
        {
            if (self.routeSearchType == AMapSearchType_NaviWalking)
            {
                return;
            }
            else if (self.routeSearchType == AMapSearchType_NaviDrive)
            {
                self.routeSearchType = AMapSearchType_NaviWalking;
                [self calRoute];
            }
        }
        else if (index == 1)
        {
            if (self.routeSearchType == AMapSearchType_NaviDrive)
            {
                return;
            }
            else if (self.routeSearchType == AMapSearchType_NaviWalking)
            {
                self.routeSearchType = AMapSearchType_NaviDrive;
                [self calRoute];
            }
        }
    }];
}


#pragma mark - 设置地图
- (void)setupMap
{
    if (!self.mapView)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        self.mapView.showsUserLocation = YES;
        self.mapView.delegate = self;
        self.mapView.zoomLevel = 16.1;
        self.mapView.zoomEnabled = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        self.mapView.showsCompass = NO;
        self.mapView.showsScale = NO;
        [self.view addSubview:self.mapView];
    }
}

#pragma mark - 设置搜索对象
- (void)setupSearchApi
{
    if (!self.searchApi)
    {
        self.searchApi = [[AMapSearchAPI alloc] initWithSearchKey:MAMapKey Delegate:self];
    }
}

#pragma mark - 计算路径
- (void)calRoute
{
    
    _startPointAnnotation = [[FGNaviPointAnnotation alloc] init];
    _startPointAnnotation.title = @"起点";
    _startPointAnnotation.navPointType = NavPointAnnotationStart;
    _startPointAnnotation.coordinate = self.currentLocation.coordinate;
    [self.annotations addObject:_startPointAnnotation];
    
    _endPointAnnotation = [[FGNaviPointAnnotation alloc] init];
    _endPointAnnotation.title = @"终点";
    _endPointAnnotation.navPointType = NavPointAnnotationEnd;
    _endPointAnnotation.coordinate = self.endCoordinate;
    [self.annotations addObject:_endPointAnnotation];
    
    
    if (_endPointAnnotation == nil || _currentLocation == nil || self.searchApi == nil)
    {
        NSLog(@"path search failed");
        return;
    }
    
    //构造AMapNavigationSearchRequest对象，配置查询参数
    AMapNavigationSearchRequest *naviRequest= [[AMapNavigationSearchRequest alloc] init];
    naviRequest.searchType = self.routeSearchType;
    naviRequest.requireExtension = YES;
    naviRequest.origin = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude   longitude:_currentLocation.coordinate.longitude];
    naviRequest.destination = [AMapGeoPoint locationWithLatitude:self.endCoordinate.latitude longitude:self.endCoordinate.longitude];
    
    //发起路径搜索
    [self.searchApi AMapNavigationSearch: naviRequest];
}

- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}

- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        
        free(coordinates), coordinates = NULL;
    }];
    
    return polylines;
}


#pragma mark - AMapSearch Delegate
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    //    NSLog(@"request: %@", request);
    //    NSLog(@"response: %@", response);
    if (response.count > 0)
    {
        [self.mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;
        
        // 只显示第一条
        _pathPolylines = [self polylinesForPath:response.route.paths[0]];
        [self.mapView addOverlays:_pathPolylines];
        
        [self.mapView addAnnotations:self.annotations];
        [self.mapView showAnnotations:self.annotations animated:YES];
        [ProgressHUD dismiss];
    }
}


#pragma mark - MapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (_currentLocation.coordinate.latitude == 0 && _currentLocation.coordinate.longitude == 0)
    {
        _currentLocation = [userLocation.location copy];
        [self calRoute];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[FGNaviPointAnnotation class]])
    {
        static NSString *annotationIdentifier = @"annotationIdentifier";
        
        FGNavPointAnnotationView *pointAnnotationView = (FGNavPointAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (pointAnnotationView == nil)
        {
            pointAnnotationView = [[FGNavPointAnnotationView alloc] initWithAnnotation:annotation
                                                                       reuseIdentifier:annotationIdentifier];
        }
        
        pointAnnotationView.canShowCallout = NO;
        pointAnnotationView.draggable      = NO;
        
        FGNaviPointAnnotation *navAnnotation = (FGNaviPointAnnotation *)annotation;
        
        if (navAnnotation.navPointType == NavPointAnnotationStart)
        {
            [pointAnnotationView setImage:[UIImage imageNamed:@"icon_route_start"]];
        }
        else if (navAnnotation.navPointType == NavPointAnnotationEnd)
        {
            [pointAnnotationView setImage:[UIImage imageNamed:@"icon_route_end"]];
        }
        return pointAnnotationView;
    }
    
    return nil;
}


- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 5.0f;
        polylineView.strokeColor = LJHColor(0, 87, 255);
        
        return polylineView;
    }
    return nil;
}

- (void)dealloc
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
    self.mapView = nil;
}

@end
