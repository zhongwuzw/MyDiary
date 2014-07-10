//
//  LocationViewController.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-10.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MAMapKit.h"

@interface LocationViewController : UIViewController
<CLLocationManagerDelegate, MAMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MAMapView *mapView;

@end
