//
//  MeContentView.m
//  MyDiary
//
//  Created by zhongwu on 14-7-17.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "MeContentView.h"
#import "AboutMeViewController.h"
#import "TestViewController.h"

@implementation MeContentView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.swipeDelegate != nil && [self.swipeDelegate respondsToSelector:@selector(contentSelectedIndexChanged:)]) {
        int index = self.tableView.contentOffset.y / self.frame.size.width;
        [self.swipeDelegate contentSelectedIndexChanged:index];
    }
}

- (void)selectIndex:(int)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pt = self.tableView.contentOffset;
    [self.swipeDelegate scrollOffsetChanged:pt];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.frame = frame;
        
        self.backgroundColor = [UIColor clearColor];
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollsToTop = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        self.tableView.frame = self.bounds;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.pagingEnabled = YES;
        self.tableView.backgroundColor = RGBCOLOR(192, 192, 192);
        self.tableView.bounces = YES;
        [self addSubview:self.tableView];
        self.cellDataSource = array;
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = self.cellDataSource.count;
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        TestViewController *vc = [self.cellDataSource objectAtIndex:[indexPath row]];
        vc.view.frame = cell.bounds;
        [cell.contentView addSubview:vc.view];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
