//
//  DiaryStore.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Diary.h"

@interface DiaryStore : NSObject
{
    NSMutableArray  *diaries;    
}

+ (DiaryStore *)defaultStore;

- (NSArray *)diaries;
- (Diary *)createDiary;

-(void)removeDiary:(Diary *)d;
- (void)moveDiaryAtIndex:(int)from toIndex:(int)to;

- (NSString *)diaryArchivePath;

- (BOOL)saveChanges;

- (void)fetchDiary;

@end
