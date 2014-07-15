//
//  ScrollTestView.m
//  MyDiary
//
//  Created by zhongwu on 14-7-15.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "ScrollTestView.h"

@implementation ScrollTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageArray = @[@"recommand_banner_default.jpg",@"recommond_header_bander_default",@"icon.png",@"Default.png"];
        
        [self configUserInterface];
        [self configAdvent:imageArray];
        timeNum = 3;
        tend = YES;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:timeNum target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)handleTimer{
    if (!tend) {
        _pageControl.currentPage++;
        if (_pageControl.currentPage == _pageControl.numberOfPages - 1) {
            tend = YES;
        }
    }
    else
    {
        _pageControl.currentPage--;
        if (_pageControl.currentPage == 0) {
            tend = NO;
        }
    }
    [UIView animateWithDuration:0.8 animations:^{
        _sv.contentOffset = CGPointMake(_pageControl.currentPage*320, 0);
    }];
}

- (void)configAdvent:(NSArray *)imgArray
{
    [self adImg:imageArray];
    [self setCurrentPage:_pageControl.currentPage];
    
}

- (void)setCurrentPage:(NSInteger)secondPage
{
    for (NSUInteger subviewIndex = 0; subviewIndex < [_pageControl.subviews count]; subviewIndex++) {
        UIImageView *subView = [_pageControl.subviews objectAtIndex:subviewIndex];
        if ([subView isKindOfClass:[UIImageView class]]) {
            CGSize size;
            size.height = 8;
            size.width = 8;
            [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, size.width, size.height)];
            
            if (subviewIndex == secondPage) {
                [subView setImage:[UIImage imageNamed:@"mtll_adt_lately_share_page_no_cur"]];
            }
            else
            {
                [subView setImage:[UIImage imageNamed:@"mtll_adt_lately_share_page_no_cur"]];
            }
            
        }
    }
}

- (void)adImg:(NSArray *)arr
{
    [_sv setContentSize:CGSizeMake(320*[arr count], 80)];
    _pageControl.numberOfPages = [arr count];
    
    for (int i = 0; i < [arr count]; i++) {
        NSString *imageName = [arr objectAtIndex:i];
        UIButton *img = [[UIButton alloc] initWithFrame:CGRectMake(320*i, 0, 320, 80)];
        [_sv addSubview:img];
        [img setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"我滑动了");
    _pageControl.currentPage = scrollView.contentOffset.x/320;
    [self setCurrentPage:_pageControl.currentPage];
}

- (void)configUserInterface
{
    _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    _sv.delegate = self;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    _sv.pagingEnabled = YES;
    
    [self addSubview:_sv];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(320/2-15, _sv.frame.size.height - 23, 30, 30)];
    
    [self addSubview:_pageControl];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
