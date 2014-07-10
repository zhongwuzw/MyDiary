//
//  DiaryListTableViewCell.m
//  MyDiary
//
//  Created by zhongwu on 14-7-7.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "DiaryListTableViewCell.h"

@implementation DiaryListTableViewCell

//- (void)setName:(NSString *)name
//{
//    if (![name isEqualToString:_name]) {
//        _name = [name copy];
//        _nameValue.text = _name;
//    }
//}
//
//- (void)setColor:(NSString *)color
//{
//    if (![color isEqualToString:_color]) {
//        _color = [color copy];
//        _colorValue.text = _color;
//    }
//}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
