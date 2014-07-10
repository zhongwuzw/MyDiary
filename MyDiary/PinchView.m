//
//  PinchView.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-18.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "PinchView.h"

@implementation PinchView

-(id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handlePinch:)];
        
        [self addGestureRecognizer:pinch];
    }
    return self;
}

-(void)handlePinch:(UIPinchGestureRecognizer *)uipgr{
    if (uipgr.state == UIGestureRecognizerStateEnded) {
        currentScale = uipgr.scale;
    }else if (uipgr.state == UIGestureRecognizerStateBegan &&
              currentScale != 0.0f){
        uipgr.scale = currentScale;
    }
    
    if (uipgr.scale != NAN && uipgr.scale != 0.0f) {
        self.transform = CGAffineTransformMakeScale(
                                                    uipgr.scale, uipgr.scale);
    }
}

@end
