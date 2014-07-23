//
//  XzxmEngine.m
//  MyDiary
//
//  Created by zhongwu on 14-7-12.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "XzxmEngine.h"
#import "UserListItem.h"

#define XZXM_USER_LIST_URL(__C1__) [NSString stringWithFormat:@"xzxm/user_list/%@", __C1__]

#define XZXM_PROFILE_IMAGE_URL(__C1__) [NSString stringWithFormat:@"images/%@", __C1__]

@implementation XzxmEngine

- (void)prepareHeaders:(MKNetworkOperation *)operation
{
   // self.accessToken = @"zhongwu";
    if (self.accessToken) {
        [operation setAuthorizationHeaderValue:self.accessToken forAuthType:@""];
    }
    
    [super prepareHeaders:operation];
}

- (MKNetworkOperation *)homePageUserList:(NSString *)userTokens completionHandler:(HomeUserListBlock)completion errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:XZXM_USER_LIST_URL(userTokens) params:nil httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
    {
        NSMutableArray *responseArray = [completedOperation responseJSON];
            
        NSMutableArray *userListItems = [NSMutableArray array];
        [responseArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
            [userListItems addObject:[[UserListItem alloc] initWithDictionary:obj]];
        }];
        
        completion(userListItems);
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)getProfilePic:(NSString *)pic_path completionHandler:(GetProfilePicBlock)completion errorHanler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:XZXM_PROFILE_IMAGE_URL(pic_path) params:nil httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
        UIImage *profile_image = [completedOperation responseImage];
        
        completion(profile_image);
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)loginWithName:(NSString *)loginName password:(NSString *)password onSucceeded:(VoidBlock)succeedBlock onError:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:LOGIN_URL];
    
    [op setUsername:loginName password:password basicAuth:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *completionOperation){
        NSDictionary *responseDict = [completionOperation responseJSON];
        self.accessToken = [responseDict objectForKey:@"accessToken"];
        succeedBlock();
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
