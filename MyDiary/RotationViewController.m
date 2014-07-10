//
//  RotationViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-3.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()

@end

@implementation RotationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                        duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.buttonUL.frame = CGRectMake(36, 25, 110, 110);
        self.buttonUR.frame = CGRectMake(178, 25, 110, 110);
        self.buttonL.frame =  CGRectMake(36, 151, 110, 110);
        self.buttonR.frame =  CGRectMake(178, 151, 110, 110);
        self.buttonLL.frame = CGRectMake(36, 277, 110, 110);
        self.buttonLR.frame = CGRectMake(178, 277, 110, 110);
    } else {
        self.buttonUL.frame = CGRectMake(36, 15, 110, 110);
        self.buttonUR.frame = CGRectMake(36, 135, 110, 110);
        self.buttonL.frame =  CGRectMake(177, 15, 110, 110);
        self.buttonR.frame =  CGRectMake(177, 135, 110, 110);
        self.buttonLL.frame = CGRectMake(328, 15, 110, 110);
        self.buttonLR.frame = CGRectMake(328, 135, 110, 110);
    }
}

@end
