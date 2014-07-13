//
//  JSONModel.h
//  MyDiary
//
//  Created by zhongwu on 14-7-13.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModel : NSObject
<NSCopying,NSMutableCopying>

- (id)initWithDictionary:(NSMutableDictionary *)jsonObject;

@end
