//
//  DiaryListViewController.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-14.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailDiaryViewController.h"
#import "CreateDiaryViewController.h"
#import "ImageStore.h"

@interface DiaryListViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate, CreateDiaryViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray   *diaries;
@property (nonatomic, strong) UIColor *diaryTitleColor;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (strong, nonatomic) NSArray *computers;

-(UIView *) headerView;

@end
