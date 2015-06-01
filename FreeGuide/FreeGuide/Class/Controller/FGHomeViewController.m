//
//  FGHomeViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/5/25.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGHomeViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#define kDefaultLocationZoomLevel 16.1
#define UUID_PILOTBASE @"AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"
@interface FGHomeViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@property (strong, nonatomic) UIButton *locateBtn;
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
    [self setupNav];
    [self setupMap];
    [self setupUI];
    [self setupBeacon];
    self.title = @"FreeGuide";
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



- (void)setupNav
{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(testAction)];
}

- (void)testAction
{
//    FGNotifyViewController *testVC = [[FGNotifyViewController alloc] init];
//    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark - 设置UI
- (void)setupUI
{
    UIButton *locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locateBtn setImage:[UIImage imageNamed:@"icon_map_locate"] forState:UIControlStateNormal];
    [locateBtn setBackgroundImage:[UIImage resizedImageWithName:@"mapTabButton"] forState:UIControlStateNormal];
    [locateBtn setBackgroundImage:[UIImage resizedImageWithName:@"mapTabButtonSelected"] forState:UIControlStateSelected];
    [locateBtn addTarget:self action:@selector(locateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:locateBtn];
    self.locateBtn = locateBtn;
    
    [locateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mapView.left).offset(10);
        make.bottom.equalTo(self.mapView.bottom).offset(- 20);
        make.height.equalTo(@(36));
        make.width.equalTo(@(36));
    }];
    
    
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBar];
    
    [bottomBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(@(44));
    }];
    
    CGFloat bottomBtnW = kScreen_Width / 5;
    int bottomBtnCount = 5;
    NSArray *bottomBtnTitles = @[@"景区简介",@"景区导游",@"景区优惠",@"景区活动",@"健康生活"];
    for (int index = 0; index < bottomBtnCount; index ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        CGFloat btnW = bottomBtnW;
        CGFloat btnH = 44;
        CGFloat btnX = index * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = index;
        [btn setTitleColor:LJHColor(102, 102, 102) forState:UIControlStateNormal];
        [btn setTitle:bottomBtnTitles[index] forState:UIControlStateNormal];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomBar addSubview:btn];
    }
}

- (void)bottomBtnClick:(UIButton *)btn
{
    LJHLog(@"%d",btn.tag);
}


- (void)locateBtnClick
{
    if (self.mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
    }
}

#pragma mark - 设置地图
- (void)setupMap
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.zoomLevel = kDefaultLocationZoomLevel;
    self.mapView.zoomEnabled = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    [self.view addSubview:self.mapView];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{

}



#pragma mark <CLLocationManagerDelegate>

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

//            if (minor == 10002)
//            {
//                UILocalNotification *notification = [[UILocalNotification alloc] init];
//                notification.alertBody = @"促销打折!";
//                notification.soundName = @"Default";
//                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//            }
//            else if (minor == 10003)
//            {
//                UILocalNotification *notification = [[UILocalNotification alloc] init];
//                notification.alertBody = @"语音导游!";
//                notification.soundName = @"Default";
//                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//            }
//            else if (minor == 10004)
//            {
//                UILocalNotification *notification = [[UILocalNotification alloc] init];
//                notification.alertBody = @"预订酒店!";
//                notification.soundName = @"Default";
//                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//            }
        }
//        self.outputTextView.text = tmpString;
    }
}
@end
