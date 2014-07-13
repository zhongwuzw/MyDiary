//
//  JSONModel.m
//  MyDiary
//
//  Created by zhongwu on 14-7-13.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel

- (id)initWithDictionary:(NSMutableDictionary *)jsonObject
{
    if ((self = [super init])) {
        [self setValuesForKeysWithDictionary:jsonObject];
    }
    return self;
}

@end
