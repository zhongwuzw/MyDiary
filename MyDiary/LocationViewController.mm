//
//  LocationViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-10.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
-(NSString *)mapViewSearchKey
{
    return @"";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"iOS设备的定位服务已经开启。");
        
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorized:
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@"应用程序可以访问定位服务。");
                
//                // 创建并初始化location manager对象
//                self.locationManager = [[CLLocationManager alloc] init];
//                
//                // 完成下面一行以后会出现警告提示，暂时忽略不用管它
//                self.locationManager.delegate = self;
//                
//                // 设定location manager的距离监测为最小距离
//                [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
//                
//                // 设定location manager的精确度
//                [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//                
//                // 立即开始定位当前位置
//                [self.locationManager startUpdatingLocation];

                self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
                self.mapView.mapType = MAMapTypeStandard;
                self.mapView.delegate = self;
                
                [self.mapView setShowsUserLocation:YES];
                
                [self.view addSubview:self.mapView];
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"定位服务被使用者禁止了。");
                break;
            
                self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
                self.mapView.mapType = MAMapTypeStandard;
                self.mapView.delegate = self;
                
                if (self.mapView) {
                    CLLocationCoordinate2D center = {39.91669,116.39716};
                    MACoordinateSpan span = {0.04,0.03};
                    MACoordinateRegion region = {center,span};
                    [self.mapView setRegion:region animated:NO];
                    [self.view addSubview:self.mapView];
                }

                break;
            case kCLAuthorizationStatusRestricted:
                NSLog(@"家长控制限制了定位服务。");
                break;
            default:
                break;
        }
    }else{
        NSLog(@"iOS系统的定位服务被禁止了。");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = (CLLocation *)[locations objectAtIndex:0];
    
    NSLog(@"%@",location);
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    NSLog(@"设备定位失败: %@", error);
}

@end
