//
//  YahooEngine.h
//  MyDiary
//
//  Created by zhongwu on 14-7-11.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

@interface YahooEngine : MKNetworkEngine

typedef void (^CurrencyResponseBlock)(double rate);

- (MKNetworkOperation *)currencyRateFor:(NSString *)sourceCurrency
                             inCurrency:(NSString *)targetCurrency
                           onCompletion:(CurrencyResponseBlock)completion
                                onError:(MKNKErrorBlock)errorBlock;

@end
