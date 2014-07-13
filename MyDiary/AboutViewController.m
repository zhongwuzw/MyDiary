//
//  ViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-5.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "AboutViewController.h"
#import "AppDelegate.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取故事板中Segmented Control当前被选中按钮索引
    switch (self.authors.selectedSegmentIndex) {
            // 如果当前第一作者按钮处于选中状态
        case 0:
            self.qqNumber.text = @"QQ：1302606708";
            self.weiBo.text = @"腾讯微博：liuming_cn";
            self.authorImage.image = [UIImage imageNamed:@"liuming.png"];
            break;
        case 1:
            self.qqNumber.text = @"QQ：1234567890";
            self.weiBo.text = @"腾讯微博：xxxxxxxx";
            self.authorImage.image = [UIImage imageNamed:@"zhuge.png"];
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"AboutViewController 将要出现！");
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"AboutViewController 已经出现！");
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"AboutViewController 将要消失！");
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (self.currencyOperation) {
        [self.currencyOperation cancel];
        self.currencyOperation = nil;
    }
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authorChanged:(id)sender {
    // 获取用户点击Segmented Control的按钮索引值，索引值由左向右从0开始
    int value = [(UISegmentedControl*)sender selectedSegmentIndex];
    
    // 根据索引值设置界面元素的显示信息
    switch (value) {
        case 0:
            // 第一作者的显示信息
            self.qqNumber.text = @"QQ：1302606708";
            self.weiBo.text = @"腾讯微博：liuming_cn";
            self.authorImage.image = [UIImage imageNamed:@"liuming.png"];
            break;
        case 1:
            // 第二作者的显示信息
            self.qqNumber.text = @"QQ：1234567890";
            self.weiBo.text = @"腾讯微博：xxxxxxxx";
            self.authorImage.image = [UIImage imageNamed:@"zhuge.png"];
            break;
        default:
            break;
    }
}

- (IBAction)convertCurrency:(UIButton *)sender {
    self.currencyOperation = [ApplicationDelegate.yahooEngine currencyRateFor:@"SGD" inCurrency:@"USD" onCompletion:^(double rate){
        [[[UIAlertView alloc] initWithTitle:@"Today's Singapore Dollar Rates" message:[NSString stringWithFormat:@"%.2f",rate] delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil] show];
    }onError:^(NSError *error){
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
}

@end
