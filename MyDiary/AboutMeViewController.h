//
//  AboutMeViewController.h
//  MyDiary
//
//  Created by zhongwu on 14-7-16.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeContentView.h"
#import "MeBarView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define barHeight 27
@interface AboutMeViewController : UIViewController

@property int currentIndex;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) MeContentView *meContentView;
@property (strong, nonatomic) MeBarView *meBarView;


@end
