//
//  AppDelegate.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-5.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YahooEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YahooEngine *yahooEngine;

@end
