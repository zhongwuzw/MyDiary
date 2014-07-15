//
//  ScrollTestView.h
//  MyDiary
//
//  Created by zhongwu on 14-7-15.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTestView : UIView
<UIScrollViewDelegate>
{
    int timeNum;
    BOOL tend;
    NSArray *imageArray;
}

@property int timeNum;
@property BOOL tend;
@property (strong, nonatomic)NSArray *imageArray;
@property (strong, nonatomic)NSTimer *timer;

@property (strong, nonatomic)UIScrollView *sv;
@property (strong, nonatomic)UIPageControl *pageControl;

- (void)configAdvent:(NSArray *)imgArray;
- (void)configUserInterface;

@end
