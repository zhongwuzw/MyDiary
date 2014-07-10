//
//  Diary.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-7.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diary : NSObject<NSCoding>

+ (id)createDiary;

-(id)initWithTitle:(NSString *)theTitle content:(NSString *)theContent;

@property (nonatomic, strong) NSString   *title;
@property (nonatomic, strong) NSString   *content;
@property (nonatomic, readonly, getter = dateCreate) NSDate *dateCreate;
@property (nonatomic, strong) NSString   *photoKey;
@property (nonatomic, strong) NSString   *audioFileName;
@end
