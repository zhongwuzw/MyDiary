//
//  TouchRecognizerViewController.h
//  MyDiary
//
//  Created by 刘铭 on 12-12-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFillingComponent 0
#define kBreadComponent 1

@interface TouchRecognizerViewController : UIViewController
<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *doublePicker;

@property (strong, nonatomic) NSDictionary *stateZips;
@property (strong, nonatomic) NSArray *fillingTypes;
@property (strong, nonatomic) NSArray *breadTypes;

@end
