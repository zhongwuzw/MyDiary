//
//  RotationView.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "RotationView.h"

@implementation RotationView

-(id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
        
        UIRotationGestureRecognizer *rotation =
        [[UIRotationGestureRecognizer alloc]
         initWithTarget:self action:@selector(handleRotation:)];
        
        self.gestureRecognizers = [NSArray arrayWithObject:rotation];
    }
    return self;
}

-(void) handleRotation:(UIRotationGestureRecognizer *)uirgr
{
    self.transform = CGAffineTransformMakeRotation
    (rotationAngleInRadians + uirgr.rotation);
    
    if (uirgr.state == UIGestureRecognizerStateEnded) {
        rotationAngleInRadians += uirgr.rotation;
    }
}
@end
