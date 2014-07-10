//
//  TapView.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "TapView.h"

@implementation TapView

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
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    startLocation = pt;
    [[self superview] bringSubviewToFront:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    float dx = pt.x - startLocation.x;
    float dy = pt.y - startLocation.y;
    
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    self.center = newcenter;
}

@end
