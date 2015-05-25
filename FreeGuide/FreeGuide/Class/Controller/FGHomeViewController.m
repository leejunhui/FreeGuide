//
//  FGHomeViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/5/25.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGHomeViewController.h"
#define kDefaultZoomLevel 16.1
@interface FGHomeViewController ()<MAMapViewDelegate>
@property (strong, nonatomic) MAMapView *mapView;
@end

@implementation FGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMap];
    self.title = @"FreeGuide";
}

- (void)setupMap
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectZero];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.zoomLevel = kDefaultZoomLevel;
    [self.view addSubview:self.mapView];
    
    [self.mapView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
}

@end
