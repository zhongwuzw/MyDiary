//
//  LongPressView.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-18.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "LongPressView.h"

@implementation LongPressView

-(id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(handleLongPress:)];
        // 长按手势必须使用1个手指
        longPressGestureRecognizer.numberOfTouchesRequired = 1;
        
        // 手指必须按住视图至少1秒的时间
        longPressGestureRecognizer.minimumPressDuration = 1.0;
        
        [self addGestureRecognizer:longPressGestureRecognizer];
    }
    return self;
}

-(void) handleLongPress:(UILongPressGestureRecognizer *) uilpgr
{
    [self removeGestureRecognizer:uilpgr];
    
    if (uilpgr.numberOfTouchesRequired == 1) {
        self.gestureRecognizers = nil;
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"长按手势"
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"确认"
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    [self addGestureRecognizer:uilpgr];
}

@end
