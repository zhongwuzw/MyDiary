//
//  PanView.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "PanView.h"

@implementation PanView

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
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(handlePan:)];
        
        // 设置最少和最多有几个手指触摸
        pan.minimumNumberOfTouches = 1;
        pan.maximumNumberOfTouches = 1;
        
        self.gestureRecognizers = [NSArray arrayWithObject:pan];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    previousLocation = self.center;
}

-(void) handlePan:(UIPanGestureRecognizer *) uipgr
{
    if (uipgr.state != UIGestureRecognizerStateEnded &&
        uipgr.state != UIGestureRecognizerStateFailed) {
        CGPoint translation = [uipgr translationInView:self.superview];
        self.center = CGPointMake(previousLocation.x + translation.x,
                                  previousLocation.y + translation.y);
    }
}

@end
