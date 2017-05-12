//
//  TCacheService.m
//  TagQ
//
//  Created by 李浩 on 2017/3/29.
//  Copyright © 2017年 Genius. All rights reserved.
//

#import "TNetworkCacheService.h"
#import <TMarco/TMarco.h>
#import <FHCategory/FHCategory.h>

@implementation TNetworkCacheService

+ (instancetype)cacheServiceWithPath:(NSString *)cachePath runQueue:(dispatch_queue_t)queue {
    NSString* cache_path = cachePath ? [cachePath copy] : [kPathCache stringByAppendingPathComponent:@"networkCacheService"];
    dispatch_queue_t run_queue = queue ? queue : dispatch_queue_create("com.network.cacheService", DISPATCH_QUEUE_SERIAL);
    return [[TNetworkCacheService alloc] initWithCachePath:cache_path runQueue:run_queue];
}

- (NSString*)cacheKeyWithString:(NSString *)str {
    return [self cacheKeyWithString:str extraKey:nil];
}

- (NSString*)cacheKeyWithString:(NSString *)str extraKey:(NSString *)extraKey {
    return [[str stringByAppendingString:extraKey?extraKey:@""] fh_md5String];
}

- (NSString*)cachePathWithKey:(NSString *)key {
    return [self cachePathWithKey:key extraKey:nil];
}

- (NSString*)cachePathWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    return [self.cachePath stringByAppendingPathComponent:[self cacheKeyWithString:key extraKey:extraKey]];
}

- (void)cacheData:(id)data key:(NSString *)key {
    [self cacheData:data key:key extraKey:nil];
}

- (void)cacheData:(id)data key:(NSString *)key extraKey:(NSString *)extraKey {
    NSParameterAssert(data);
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        data = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSAssert(isKindofClass(data, NSData), @"data不满足条件");
    [T_ClassForceify(data, NSData) writeToFile:[self cachePathWithKey:key extraKey:extraKey] atomically:YES];
}

- (void)cacheData:(id)data key:(NSString *)key complete:(dispatch_block_t)complete {
    [self cacheData:data key:key extraKey:nil complete:complete];
}

- (void)cacheData:(id)data
              key:(NSString *)key
         extraKey:(NSString *)extraKey
         complete:(dispatch_block_t)complete {
    dispatch_async(self.opeartionQueue, ^{
        [self cacheData:data key:key extraKey:extraKey];
        dispatch_async_main(^{
            !complete?:complete();
        });
    });
}

- (NSDictionary*)dataWithKey:(NSString *)key {
   return [self dataWithKey:key extraKey:nil];
}

- (NSDictionary*)dataWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    NSString* filePath = [self cachePathWithKey:key extraKey:extraKey];
    NSData* cache_data = [NSData dataWithContentsOfFile:filePath];
    
    return !cache_data?nil:[NSJSONSerialization JSONObjectWithData:cache_data options:NSJSONReadingMutableContainers error:nil];
}

- (void)dataWithKey:(NSString *)key complete:(void (^)(__kindof id))complete {
    [self dataWithKey:key extraKey:nil complete:complete];
}

- (void)dataWithKey:(NSString *)key
           extraKey:(NSString *)extraKey
           complete:(void (^)(__kindof id))complete {
    dispatch_async(self.opeartionQueue, ^{
        NSDictionary* cache_data = [self dataWithKey:key extraKey:extraKey];
        dispatch_async_main(^{
            !complete?:complete(cache_data);
        });
    });
}


- (id)dataCacheWithURLString:(NSString*)URLString
              analysisHandle:(id(^)(NSDictionary* data))analysHandle {
    return [self dataCacheWithURLString:URLString extraKey:nil analysisHandle:analysHandle];
}

- (id)dataCacheWithURLString:(NSString *)URLString
                    extraKey:(NSString *)extraKey
              analysisHandle:(id (^)(NSDictionary *))analysHandle {
    NSDictionary* cache_data = [self dataWithKey:URLString extraKey:extraKey];
    return !analysHandle?cache_data:analysHandle(cache_data);
}

- (void)dataCacheWithURLString:(NSString*)URLString
                analysisHandle:(id(^)(NSDictionary* data))analysHandle
                      complete:(void(^)(__kindof id data))complete {
    [self dataCacheWithURLString:URLString extraKey:nil analysisHandle:analysHandle complete:complete];
}

- (void)dataCacheWithURLString:(NSString *)URLString
                      extraKey:(NSString *)extraKey
                analysisHandle:(id (^)(NSDictionary *))analysHandle complete:(void (^)(__kindof id))complete {
    dispatch_async(self.opeartionQueue, ^{
        id cache_data = [self dataCacheWithURLString:URLString extraKey:extraKey analysisHandle:analysHandle];
        dispatch_async_main(^{
            !complete?:complete(cache_data);
        });
    });
}

@end
