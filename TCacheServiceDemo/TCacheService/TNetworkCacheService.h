//
//  TCacheService.h
//  TagQ
//
//  Created by 李浩 on 2017/3/29.
//  Copyright © 2017年 Genius. All rights reserved.
//


#import "TCacheService.h"

@interface TNetworkCacheService : TCacheService

/**
 取缓存,会根据一个block尝试解析原始数据

 @param URLString cache key
 @param analysHandle 解析block
 @return 解析完成的数据
 */
- (id)dataCacheWithURLString:(NSString*)URLString
              analysisHandle:(id(^)(NSDictionary* data))analysHandle;

- (id)dataCacheWithURLString:(NSString *)URLString
                    extraKey:(NSString*)extraKey
              analysisHandle:(id (^)(NSDictionary *))analysHandle;

- (void)dataCacheWithURLString:(NSString*)URLString
                analysisHandle:(id(^)(NSDictionary* data))analysHandle
                      complete:(void(^)(__kindof id data))complete;

- (void)dataCacheWithURLString:(NSString *)URLString
                      extraKey:(NSString*)extraKey
                analysisHandle:(id (^)(NSDictionary *))analysHandle
                      complete:(void (^)(__kindof id))complete;

@end
