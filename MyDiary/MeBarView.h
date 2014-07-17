//
//  MeBarView.h
//  MyDiary
//
//  Created by zhongwu on 14-7-17.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarDelegate <NSObject>

@optional
- (void)barSelectedIndexChanged:(int)newIndex;
- (void)contentSelectedIndexChanged:(int)newIndex;
- (void)scrollOffsetChanged:(CGPoint)offSet;

@end

@interface MeBarView : UIScrollView

@property (weak, nonatomic) id <BarDelegate>clickDelegate;
@property int selectedIndex;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIView *lineView;

- (id)initWithFrame:(CGRect)frame andItems:(NSArray *)titleArray;

@end
