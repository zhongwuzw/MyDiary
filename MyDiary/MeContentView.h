//
//  MeContentView.h
//  MyDiary
//
//  Created by zhongwu on 14-7-17.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeBarView.h"

@interface MeContentView : UIView
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <BarDelegate>swipeDelegate;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cellDataSource;

- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array;
- (void)selectIndex:(int)index;

@end
