//
//  DiaryListTableViewCell.h
//  MyDiary
//
//  Created by zhongwu on 14-7-7.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryListTableViewCell : UITableViewCell

//@property (copy, nonatomic) NSString *name;
//@property (copy, nonatomic) NSString *color;
@property (weak, nonatomic) IBOutlet UILabel *nameValue;
@property (weak, nonatomic) IBOutlet UILabel *colorValue;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;
@property (weak, nonatomic) IBOutlet UILabel *introduce;

@end
