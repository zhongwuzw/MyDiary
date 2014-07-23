//
//  DiaryListTableViewCell.h
//  MyDiary
//
//  Created by zhongwu on 14-7-7.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwipeableCellDelegate
<NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
@end

@interface DiaryListTableViewCell : UITableViewCell

//@property (copy, nonatomic) NSString *name;
//@property (copy, nonatomic) NSString *color;
@property (weak, nonatomic) IBOutlet UILabel *nameValue;
@property (weak, nonatomic) IBOutlet UILabel *colorValue;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIView *myContentView;

@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;

- (IBAction)buttonClicked:(UIButton *)sender;

@end
