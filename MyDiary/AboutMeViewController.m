//
//  AboutMeViewController.m
//  MyDiary
//
//  Created by zhongwu on 14-7-16.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "AboutMeViewController.h"
#import "TestViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"轻松一刻",@"头条",@"北京",@"房产",@"移动互联",@"财经",@"科技",@"游戏",@"历史",@"军事",@"大满贯", nil];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    for (NSString *title in titleArray) {
        TestViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
        vc.tempTitle = [title stringByAppendingString:@" View controller"];
        
        [controllers addObject:vc];
    }
    
    int y = 64;
    
    self.meBarView = [[MeBarView alloc] initWithFrame:CGRectMake(0, y, 320, barHeight) andItems:titleArray];
    
    self.meBarView.backgroundColor = RGBCOLOR(230, 230, 230);
    
    [self.view addSubview:self.meBarView];
    
    self.meBarView.clickDelegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.meContentView = [[MeContentView alloc] initWithFrame:CGRectMake(0, barHeight + y, 320, self.view.frame.size.height - barHeight - y) Array:controllers];
    
    self.meContentView.swipeDelegate = self;
    [self.view addSubview:self.meContentView];
    
    if (controllers.count > 0) {
        self.currentIndex = 0;
    }
    self.titleArray = titleArray;
    self.title = [_titleArray objectAtIndex:0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
