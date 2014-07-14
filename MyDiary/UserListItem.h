//
//  UserListItem.h
//  MyDiary
//
//  Created by zhongwu on 14-7-13.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "JSONModel.h"

@interface UserListItem : JSONModel

@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *school;
@property (nonatomic, strong)NSString *education;
@property (nonatomic, strong)NSString *profileImage;
@property (nonatomic, strong)NSString *age;
@property (nonatomic, strong)NSString *height;

@end
