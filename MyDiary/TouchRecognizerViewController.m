//
//  TouchRecognizerViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-12-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "TouchRecognizerViewController.h"
#import "TapView.h"
#import "PanView.h"
#import "SwipeView.h"
#import "RotationView.h"
#import "LongPressView.h"
#import "PinchView.h"

@interface TouchRecognizerViewController ()

@end

@implementation TouchRecognizerViewController

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return 90;
    }
    else{
        return 200;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == kFillingComponent) {
        NSString *selectedState = self.fillingTypes[row];
        
        self.breadTypes = self.stateZips[selectedState];
        [self.doublePicker reloadComponent:kBreadComponent];
        [self.doublePicker selectRow:0 inComponent:kBreadComponent animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return [self.breadTypes count];
    }
    else
    {
        return [self.fillingTypes count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return self.breadTypes[row];
    }
    else
    {
        return self.fillingTypes[row];
    }
}

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
    
//    self.fillingTypes = @[@"Luck",@"Shit",@"Lando",@"das",@"dafds"];
//    self.breadTypes = @[@"a",@"b",@"c",@"d"];

    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    
    NSArray *allState = [self.stateZips allKeys];
    NSArray *sortedStates = [allState sortedArrayUsingSelector:@selector(compare:)];
    
    self.fillingTypes = sortedStates;
    
    NSString *selectedState = self.fillingTypes[0];
    self.breadTypes = self.stateZips[selectedState];
	// Do any additional setup after loading the view.
    
    /*
    TapView *tapView = [[TapView alloc]initWithImage:[UIImage
                                                      imageNamed:@"flower"]];
    tapView.center = CGPointMake(130, 130);
    
    [self.view addSubview:tapView];
     
    PanView *panView = [[PanView alloc]initWithImage:[UIImage imageNamed:@"flower"]];
    panView.center = CGPointMake(130, 130);
    [self.view addSubview:panView];
     
    SwipeView *swipeView = [[SwipeView alloc]initWithImage:[UIImage
                                                            imageNamed:@"flower"]];
    swipeView.center = CGPointMake(150, 170);
    
    [self.view addSubview:swipeView];
     
    
    RotationView *rotationView = [[RotationView alloc]initWithImage:
                                  [UIImage imageNamed:@"flower"]];
    rotationView.center = CGPointMake(150, 170);
    
    [self.view addSubview:rotationView];
     
    
    LongPressView *longPressView = [[LongPressView alloc]initWithImage:
                                    [UIImage imageNamed:@"flower"]];
    longPressView.center = CGPointMake(150, 170);
    
    [self.view addSubview:longPressView];
     */
    
   // PinchView *pinchView = [[PinchView alloc]initWithImage:
                       //     [UIImage imageNamed:@"flower"]];
   // pinchView.center = CGPointMake(150, 170);
    
   // [self.view addSubview:pinchView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
