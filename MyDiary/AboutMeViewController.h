//
//  AboutMeViewController.h
//  MyDiary
//
//  Created by zhongwu on 14-7-16.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeViewController : UIViewController
{
    int currentIndex;
    NSArray *titleArray;
    
}

- (id)initWithItems:(NSArray *)titleArray andControllers:(NSArray *)controllers;

@end
