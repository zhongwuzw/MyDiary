//
//  DiaryStore.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "DiaryStore.h"
#import "Diary.h"

static DiaryStore *defaultStore = nil;

@implementation DiaryStore
+ (DiaryStore *)defaultStore
{
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

-(void)removeDiary:(Diary *)d
{
    [diaries removeObjectIdenticalTo:d];
}

- (void)moveDiaryAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    
    Diary *d = [diaries objectAtIndex:from];
    
    [diaries removeObjectAtIndex:from];
    
    [diaries insertObject:d atIndex:to];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    
    self = [super init];

    return self;
}

-(NSArray *)diaries
{
    // 确保allDiarys被创建
    [self fetchDiary];
    
    return diaries;
}

-(Diary *)createDiary
{
    // 确保diaries被创建
    [self fetchDiary];
    
    Diary *diary = [Diary createDiary];
    
    [diaries addObject:diary];
    
    return diary;
}

- (NSString *)diaryArchivePath
{
    // 获取沙箱中Documents目录的路径列表
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 从NSArray列表中获取document目录的路径
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    // 在路径的后面添加文件名称并返回
    return [documentDirectory
            stringByAppendingPathComponent:@"diaries.data"];
}

- (BOOL)saveChanges
{
    // 返回真假值
    return [NSKeyedArchiver archiveRootObject:diaries toFile:[self diaryArchivePath]];
}

- (void)fetchDiary
{
    // 如果当前allDiarys为空，则尝试从磁盘载入
    if (!diaries) {
        NSString *path = [self diaryArchivePath];
        diaries = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    
    // 如果磁盘中不存在该文件，则创建一个新的
    if (!diaries) {
        diaries = [[NSMutableArray alloc] init];
    }
}

@end
