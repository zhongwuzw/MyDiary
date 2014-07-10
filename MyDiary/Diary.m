//
//  Diary.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-7.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "Diary.h"

@implementation Diary

+ (id)createDiary{
    Diary *newDiary = [[Diary alloc] init];
    
    return newDiary;
}

-(id)init
{
    return [self initWithTitle:@"" content:@""];
}

-(id)initWithTitle:(NSString *)theTitle content:(NSString *)theContent
{
    self = [super init];
    if (self) {
        [self setTitle:theTitle];
        [self setContent:theContent];
        _dateCreate = [[NSDate alloc] init];
    }
    return self;
}

#pragma mark - NSCoding Protocol

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    // 对于每一个实例变量，基于它的变量名进行归档
    // 并且这些对象也会被发送encodeWithCoder:消息
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.dateCreate forKey:@"dateCreate"];
    [aCoder encodeObject:self.photoKey forKey:@"photoKey"];
    [aCoder encodeObject:self.audioFileName forKey:@"audioFileName"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        // 之前实例中的所有实例变量被归档，我们需要解码他们。
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setContent:[aDecoder decodeObjectForKey:@"content"]];
        [self setPhotoKey:[aDecoder decodeObjectForKey:@"photoKey"]];
        [self setAudioFileName:[aDecoder decodeObjectForKey:@"audioFileName"]];
        
        // dateCreate是只读属性，我们不能使用setter方法，这里直接赋值给实例变量并进行retain操作
        _dateCreate = [aDecoder decodeObjectForKey:@"dateCreate"];
    }
    
    return self;
}


@end
