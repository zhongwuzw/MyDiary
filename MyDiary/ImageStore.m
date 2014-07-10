//
//  ImageStore.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-17.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//
#import "ImageStore.h"

static ImageStore *defaultImageStore = nil;

@implementation ImageStore

// 防止创建另一个该类型的实例
+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultImageStore];
}

+ (ImageStore *)defaultImageStore
{
    if (!defaultImageStore) {
        // 创建一个单例
        defaultImageStore = [[super allocWithZone:NULL] init];
    }
    return defaultImageStore;
}

- (id)init
{
    if (defaultImageStore) {
        return defaultImageStore;
    }
    
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)string
{
    // 获取Documents目录的全路径
    NSString *imagePath = [self pathInDocumentDirectory:string];
    
    // 将image对象写入到NSData之中
    NSData *d = UIImageJPEGRepresentation(image, 0.5);
    
    // 将数据写入到文件系统之中
    [d writeToFile:imagePath atomically:YES];
    
    [dictionary setObject:image forKey:string];
}

-(UIImage *)imageForKey:(NSString *)string
{
    // 首先尝试从dictionary中获取图像
    UIImage *image = [dictionary objectForKey:string];
    
    // 如果无法从dictionary中获取图像，则尝试从文件中获取
    if (!image) {
        // 从文件创建UIImage对象
        image = [UIImage imageWithContentsOfFile:
                 [self pathInDocumentDirectory:string]];
        
        // 如果从文件中获取了图像，则将其缓存
        if (image) {
            [dictionary setObject:image forKey:string];
        }else {
            NSLog(@"错误：没有找到文件：%@",
                  [self pathInDocumentDirectory:string]);
        }
    }
    
    return [dictionary objectForKey:string];
}

-(void)deleteImageForKey:(NSString *)string
{
    if (!string) {
        return;
    }
    
    NSString *path = [self pathInDocumentDirectory:string];
    [[NSFileManager defaultManager] removeItemAtPath:path
                                               error:NULL];
    
    [dictionary removeObjectForKey:string];
}

-(NSString *)pathInDocumentDirectory:(NSString *)fileName
{
    // 获取沙箱中Documents目录的路径列表
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(
                                                                       NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 从NSArray列表中获取document目录的路径
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    // 在路径的后面添加文件名称并返回
    return [documentDirectory
            stringByAppendingPathComponent:fileName];
}
@end
