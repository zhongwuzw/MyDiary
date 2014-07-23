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
#import "DiaryListTableViewCell.h"
#import "XzxmEngine.h"
#import "ImageStore.h"

@interface DiaryListViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate, CreateDiaryViewControllerDelegate, SwipeableCellDelegate>

@property (nonatomic, strong) NSMutableArray   *diaries;
@property (nonatomic, strong) UIColor *diaryTitleColor;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (strong, nonatomic) NSMutableArray *computers;

@property (strong, nonatomic) MKNetworkOperation *userListOperation;
@property (strong, nonatomic) MKNetworkOperation *userProfileOperation;
@property (strong, nonatomic) MKNetworkOperation *pullUpUserListOperation;
@property (strong, nonatomic) MKNetworkOperation *pullDownUserListOperation;

- (UIView *) headerView;
- (void)footerRefreshing;

@end
