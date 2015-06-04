//
//  FGHomeViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/5/25.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGHomeViewController.h"
#import "FGSearchViewController.h"
#import "FGPersonalInfoViewController.h"
#import "FGServiceViewController.h"
#import "FGNaviViewController.h"
#import "FGNearbyViewController.h"
#import "FGOrderTicketViewController.h"
#import "FGViewPointViewController.h"
#import "FGVoiceGuideViewController.h"
#import "FGToolBar.h"
#import "FGSearchBar.h"
#import "FGToolBarButtonModel.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#define kDefaultLocationZoomLevel 16.1
#define UUID_PILOTBASE @"AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"
@interface FGHomeViewController ()<MAMapViewDelegate,CLLocationManagerDelegate,FGToolBarDelegate,FGSearchBarDelegate>
@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) FGToolBar *toolBar;
@property (strong, nonatomic) FGSearchBar *searchBar;
@property (strong, nonatomic) UIButton *gpsButton;

/**
 *  语音导游
 */
@property (strong, nonatomic) UIButton *voiceGuideButton;

/**
 *  景点
 */
@property (strong, nonatomic) UIButton *jingDianButton;

/**
 *  购票
 */
@property (strong, nonatomic) UIButton *orderButton;


@property (assign, nonatomic) BOOL isLocated;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locManager;
@end

@implementation FGHomeViewController

#pragma mark - Life Circle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     *  隐藏掉导航栏
     */
    self.navigationController.navigationBarHidden = YES;
    
    [self setupSubViews];

}

- (void)setupSubViews
{
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.toolBar];
    [self.mapView addSubview:self.searchBar];
    [self.mapView addSubview:self.gpsButton];
    [self.mapView addSubview:self.voiceGuideButton];
    [self.mapView addSubview:self.jingDianButton];
    [self.mapView addSubview:self.orderButton];
    _mapView.delegate = self;
    _toolBar.delegate = self;
    _searchBar.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.toolBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mapView.left).offset(10);
        make.right.equalTo(self.mapView.right).offset(-10);
        make.bottom.equalTo(self.mapView.bottom).offset(-10);
        make.height.equalTo(@(44));
    }];
    
    [self.searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mapView.left).offset(10);
        make.right.equalTo(self.mapView.right).offset(-10);
        make.top.equalTo(self.mapView.top).offset(20);
        make.height.equalTo(@(44));
    }];
    
    [self.gpsButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mapView.left).offset(10);
        make.bottom.equalTo(self.toolBar.top).offset(-10);
    }];
    
    [self.voiceGuideButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.bottom).offset(10);
        make.right.equalTo(self.searchBar.right);
    }];
    
    [self.jingDianButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.voiceGuideButton.bottom).offset(10);
        make.right.equalTo(self.voiceGuideButton.right);
    }];
    
    [self.orderButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jingDianButton.bottom).offset(10);
        make.right.equalTo(self.jingDianButton.right);
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    if (userLocation.location)
    {
        [self handelMapLocateWithLocation:userLocation.location];
        
        
    }
}

- (void)handelMapLocateWithLocation:(CLLocation *)location
{
    if (self.isLocated)
    {
    return;
    }
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    [self.gpsButton setImage:[UIImage imageNamed:@"default_main_gpssearchbutton_image_normal"] forState:UIControlStateNormal];
    [self.mapView setZoomLevel:kDefaultLocationZoomLevel atPivot:[self.mapView convertCoordinate:location.coordinate toPointToView:self.view] animated:YES];
    self.isLocated = YES;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entering %@", region.identifier);
    [self.locManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"青城山欢迎您!";
    notification.soundName = @"Default";
    notification.userInfo = @{@"key":@"1",
                              @"title":@"青城山欢迎您",
                              @"body":@"青城山，全球道教主流教派全真道圣地，世界文化遗产，世界自然遗产（四川大熊猫栖息地），中国四大道教名山之一，全国重点文物保护单位，国家重点风景名胜区，国家AAAAA级旅游景区。青城山位于成都市都江堰市西南，东距成都市区68公里，处于都江堰水利工程西南10公里处。主峰老君阁海拔1260米。青城山群峰环绕起伏、林木葱茏幽翠，享有“青城天下幽”的美誉。青城山历史悠久，是中国道教发祥地之一，是全国道教十大洞天的第五洞天。青城山名胜古迹很多 ，古建筑各具特色，古今名人诗画词赋处处可见，有优美的风光和神奇的传说。全山宫观以天师洞为核心，建有建福宫、上清宫、祖师殿、圆明宫、玉清宫、朝阳洞等。青城山自古是文人墨客探幽访胜和隐居修练之地，古称“洞天福地”、“神仙都会”。青城山在历史上名称很多，曾叫“汶山”、“天谷山”、渎山、丈人山、赤城山、清城都、天国山等名。青城山被誉为“天下第五名山”。"};
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Exiting %@", region.identifier);
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"再见!";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    [self.locManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] > 0)
    {
        NSString *tmpString = @"";
        for (CLBeacon *aBeacon in beacons)
        {
            //            self.uuidLabel.text = [aBeacon.proximityUUID UUIDString];
            
            int major = [aBeacon.major intValue];
            int minor = [aBeacon.minor intValue];
            //            int rssi = (int)aBeacon.rssi;
            CLProximity proximity = aBeacon.proximity;
            NSString *distance;
            switch (proximity) {
                case CLProximityUnknown:
                    distance =  @"Unknown";
                    break;
                case CLProximityImmediate:
                    distance = @"Immediate";
                    break;
                case CLProximityNear:
                    distance = @"Near";
                    break;
                case CLProximityFar:
                    distance = @"Far";
                    break;
            }
            CLLocationAccuracy accuracy = aBeacon.accuracy;
            NSLog(@"%@", distance);
            tmpString = [tmpString stringByAppendingFormat:@"%15d%15d      %@  %f\n", major, minor, distance, accuracy];
            
        }
    }
}


#pragma mark - Custom Delegate
#pragma mark - FGToolBarDelegate
- (void)FGToolBar:(FGToolBar *)toolBar DidClickButton:(ToolBarButtonType)buttonType
{
    [self handelToolBarButtonWithButtonType:buttonType];
}

#pragma mark - FGSearchBarDelegate
- (void)FGSearchBarDidBeginSearch
{
    [self.view endEditing:YES];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGSearchViewController alloc] init]] animated:YES completion:nil];
}

#pragma mark - event response
/**
 *  定位按钮事件
 */
- (void)gpsButtonClick
{
    if(self.mapView.userTrackingMode == MAUserTrackingModeNone || self.mapView.userTrackingMode == MAUserTrackingModeFollowWithHeading)
    {
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.gpsButton setImage:[UIImage imageNamed:@"default_main_gpssearchbutton_image_normal"] forState:UIControlStateNormal];
        [self.mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
    }
    else if (self.mapView.userTrackingMode == MAUserTrackingModeFollow)
    {
        self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
        [self.gpsButton setImage:[UIImage imageNamed:@"default_main_gpsrotatingbutton_image_normal"] forState:UIControlStateNormal];
        [self.mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
    }
}

/**
 *  语音导游事件
 */
- (void)voiceGuideButtonClick
{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGVoiceGuideViewController alloc] init]] animated:YES completion:nil];
}

/**
 *  景点事件
 */
- (void)jingDianButtonClick
{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGViewPointViewController alloc] init]] animated:YES completion:nil];
}

/**
 *  订票事件
 */
- (void)orderButtonClick
{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGOrderTicketViewController alloc] init]] animated:YES completion:nil];
}

#pragma mark - private methods
/**
 *  点击底部工具栏按钮
 *
 *  @param buttonType 按钮类型
 */
- (void)handelToolBarButtonWithButtonType:(ToolBarButtonType)buttonType
{
    
    switch (buttonType)
    {
        case ToolBarButtonTypeNavi:
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGNaviViewController alloc] init]] animated:YES completion:nil];
            break;
        case ToolBarButtonTypeNear:
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGNearbyViewController alloc] init]] animated:YES completion:nil];
            break;
        case ToolBarButtonTypeService:
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGServiceViewController alloc] init]] animated:YES completion:nil];
            break;
        case ToolBarButtonTypePersonalInfo:
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[FGPersonalInfoViewController alloc] init]] animated:YES completion:nil];
            break;
        default:
            break;
    }
}

#pragma mark - getters and setters

- (MAMapView *)mapView
{
    if (!_mapView)
    {
        _mapView = [[MAMapView alloc] init];
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        _mapView.zoomLevel = kDefaultLocationZoomLevel;
        _mapView.zoomEnabled = YES;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
    }
    return _mapView;
}

- (FGToolBar *)toolBar
{
    if (!_toolBar)
    {
        NSMutableArray *models = [NSMutableArray array];
        NSArray *titles = @[@"导航",@"附近",@"服务",@"个人"];
        for (int index = 0; index < titles.count; index ++)
        {
            NSString *imageName = [NSString stringWithFormat:@"bottom_button_%d",index + 1];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image)
            {
                FGToolBarButtonModel *model = [[FGToolBarButtonModel alloc] initWithTitle:titles[index] Image:image];
                [models addObject:model];
            }
            else
            {
                NSAssert(!image, @"图片资源未能正确加载!");
            }
        }
        
        _toolBar = [[FGToolBar alloc] initWithButtonModels:models];
    }
    return _toolBar;
}

- (FGSearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[FGSearchBar alloc] init];
        
    }
    return _searchBar;
}

- (UIButton *)gpsButton
{
    if (!_gpsButton)
    {
        _gpsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gpsButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_normal"] forState:UIControlStateNormal];
        [_gpsButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_highlighted"] forState:UIControlStateHighlighted];
        [_gpsButton setImage:[UIImage imageNamed:@"default_main_gpsnormalbutton_image_normal"] forState:UIControlStateNormal];
        [_gpsButton addTarget:self action:@selector(gpsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gpsButton;
}

- (UIButton *)voiceGuideButton
{
    if (!_voiceGuideButton)
    {
        _voiceGuideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceGuideButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_normal"] forState:UIControlStateNormal];
        [_voiceGuideButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_highlighted"] forState:UIControlStateHighlighted];
        [_voiceGuideButton setImage:[UIImage imageNamed:@"voiceGuide"] forState:UIControlStateNormal];
        [_voiceGuideButton addTarget:self action:@selector(voiceGuideButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceGuideButton;
}

- (UIButton *)jingDianButton
{
    if (!_jingDianButton)
    {
        _jingDianButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_jingDianButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_normal"] forState:UIControlStateNormal];
        [_jingDianButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_highlighted"] forState:UIControlStateHighlighted];
        [_jingDianButton setImage:[UIImage imageNamed:@"scenary"] forState:UIControlStateNormal];
        [_jingDianButton addTarget:self action:@selector(jingDianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jingDianButton;
}

- (UIButton *)orderButton
{
    if (!_orderButton)
    {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_normal"] forState:UIControlStateNormal];
        [_orderButton setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_highlighted"] forState:UIControlStateHighlighted];
        [_orderButton setImage:[UIImage imageNamed:@"order"] forState:UIControlStateNormal];
        [_orderButton addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}


- (void)setupBeacon
{
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    // UUID_ESTIMOTE or UUID_HMSENSOR
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:UUID_PILOTBASE];
//    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:@"UUID_PILOTBASE"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:10005 minor:10005
                                                           identifier:@"UUID_PILOTBASE"];
    
    [self.locManager requestAlwaysAuthorization];
    
    [self.locManager startMonitoringForRegion:self.beaconRegion];
    [self.locManager startRangingBeaconsInRegion:(CLBeaconRegion *)self.beaconRegion];
}


- (void)dealloc
{
    self.toolBar.delegate = nil;
    self.searchBar.delegate = nil;
}


@end
