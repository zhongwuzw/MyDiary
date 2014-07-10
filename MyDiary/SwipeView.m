//
//  SwipeView.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "SwipeView.h"

@implementation SwipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
        // 实例化一个UISwipeGestureRecognizer实例，符合的手势会响应该类中的handleSwipe:动作
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handleSwipe:)];
        
        // 定义的手势只支持向右轻划
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        // 定义的手势要求只使用一个手指
        swipe.numberOfTouchesRequired = 1;
        
        self.gestureRecognizers = [NSArray arrayWithObject:swipe];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
}

-(void) handleSwipe:(UISwipeGestureRecognizer *) uisgr
{
    if (uisgr.direction & UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"向上轻划！");
    }
    if (uisgr.direction & UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"向下轻划！");
    }
    if (uisgr.direction & UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"向左轻划！");
    }
    if (uisgr.direction & UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"向右轻划！");
    }
}

@end
