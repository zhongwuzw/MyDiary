//
//  YahooEngine.m
//  MyDiary
//
//  Created by zhongwu on 14-7-11.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "YahooEngine.h"

#define YAHOO_URL(__C1__, __C2__) [NSString stringWithFormat:@"d/quotes.csv?e=.csv&f=sl1d1t1&s=%@%@=X", __C1__, __C2__]

@implementation YahooEngine

- (MKNetworkOperation *)currencyRateFor:(NSString *)sourceCurrency inCurrency:(NSString *)targetCurrency onCompletion:(CurrencyResponseBlock)completion onError:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:YAHOO_URL(sourceCurrency, targetCurrency) params:nil httpMethod:@"GET"];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
        NSString *valurString = [[completedOperation responseString]
                                 componentsSeparatedByString:@","][1];
        
        DLog(@"%@",valurString);
        
        if ([completedOperation isCachedResponse]) {
            DLog(@"Data from cache %@",[completedOperation responseString]);
        }
        else
        {
            DLog(@"Data from server %@",[completedOperation responseString]);
        }
        
        completion([valurString doubleValue]);
        
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *error){
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
