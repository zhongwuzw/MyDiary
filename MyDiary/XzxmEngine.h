//
//  XzxmEngine.h
//  MyDiary
//
//  Created by zhongwu on 14-7-12.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

@interface XzxmEngine : MKNetworkEngine

typedef void (^HomeUserListBlock)(NSMutableArray *userList);
typedef void (^GetProfilePicBlock)(UIImage *profilePic);
typedef void (^VoidBlock)(void);

#define LOGIN_URL @"login"

@property (copy, nonatomic) NSString *accessToken;

- (MKNetworkOperation *)homePageUserList:(NSString *)userTokens completionHandler:(HomeUserListBlock)completion errorHandler:(MKNKErrorBlock)errorBlock;

- (MKNetworkOperation *)getProfilePic:(NSString *)pic_path completionHandler:(GetProfilePicBlock)completion errorHanler:(MKNKErrorBlock)errorBlock;

- (MKNetworkOperation *)loginWithName:(NSString *)loginName password:(NSString *)password onSucceeded:(VoidBlock)succeedBlock onError:(MKNKErrorBlock)errorBlock;

@end
