//
//  ImageStore.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (ImageStore *)defaultImageStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)string;
- (UIImage *)imageForKey:(NSString *)string;
- (void)deleteImageForKey:(NSString *)string;
@end