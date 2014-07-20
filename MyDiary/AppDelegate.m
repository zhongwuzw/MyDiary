//
//  AppDelegate.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-5.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "AppDelegate.h"
#import "DiaryStore.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.yahooEngine = [[YahooEngine alloc] initWithHostName:@"download.finance.yahoo.com"];
    [self.yahooEngine useCache];
    
    self.xzxmEngine = [[XzxmEngine alloc] initWithHostName:@"localhost" portNumber:8001 apiPath:nil customHeaderFields:nil];
    
 //   [self.xzxmEngine useCache];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[DiaryStore defaultStore] saveChanges];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[DiaryStore defaultStore] saveChanges];
}

@end