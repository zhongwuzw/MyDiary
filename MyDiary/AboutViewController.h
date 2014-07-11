//
//  ViewController.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-5.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) MKNetworkOperation *currencyOperation;
@property (weak, nonatomic) IBOutlet UILabel *qqNumber;
@property (weak, nonatomic) IBOutlet UILabel *weiBo;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *authors;

- (IBAction)authorChanged:(id)sender;

- (IBAction)convertCurrency:(UIButton *)sender;


@end
