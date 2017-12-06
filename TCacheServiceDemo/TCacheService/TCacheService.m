//
//  TCacheService.m
//  TagQ
//
//  Created by 李浩 on 2017/4/3.
//  Copyright © 2017年 Genius. All rights reserved.
//

#import "TCacheService.h"
#import <TMarco/TMarco.h>

#define Default_Assert @"此方法必须被子类重写"

@implementation TCacheService

+ (instancetype)cacheServiceWithPath:(NSString *)cachePath {
    return [[TCacheService alloc] initWithCachePath:cachePath runQueue:nil];
}

+ (instancetype)cacheServiceWithPath:(NSString *)cachePath runQueue:(dispatch_queue_t)queue {
    return [[TCacheService alloc] initWithCachePath:cachePath runQueue:queue]; 
}

- (instancetype)initWithCachePath:(NSString*)cachePath runQueue:(dispatch_queue_t)queue {
    self = [super init];
    if (self) {
        _cachePath = cachePath ? [cachePath copy] : ([kPathCache stringByAppendingPathComponent:@"cacheService"]);
        _opeartionQueue = queue ? queue : dispatch_queue_create("com.cacheService.tagq", DISPATCH_QUEUE_SERIAL);
        if (![[NSFileManager defaultManager] fileExistsAtPath:_cachePath isDirectory:NULL]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

- (NSString*)cacheKeyWithString:(NSString*)str {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (NSString*)cacheKeyWithString:(NSString *)key extraKey:(NSString *)extraKey {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (NSString*)cachePathWithKey:(NSString*)key {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (NSString*)cachePathWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (NSString *)cacheRelativePathWithKey:(NSString *)key {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (NSString *)cacheRelativePathWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (void)cacheData:(id)data key:(NSString*)key {
    NSAssert(NO, Default_Assert);
}

- (void)cacheData:(id)data key:(NSString *)key extraKey:(NSString *)extraKey {
    NSAssert(NO, Default_Assert);
}

- (void)cacheData:(id)data
                      key:(NSString *)key
                 complete:(dispatch_block_t)complete {
    NSAssert(NO, Default_Assert);
}

- (void)cacheData:(id)data
              key:(NSString *)key
         extraKey:(NSString *)extraKey
         complete:(dispatch_block_t)complete {
    NSAssert(NO, Default_Assert);
}

- (void)removeCacheWithKey:(NSString*)key {
    [self removeCacheWithKey:key extrakey:nil];
}

- (void)removeCacheWithKey:(NSString *)key extrakey:(NSString *)extraKey {
    NSString* filePath = [self cachePathWithKey:key extraKey:extraKey];
    if (filePath == nil || filePath.length <= 0) return;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

- (void)removeCacheWithKey:(NSString *)key complete:(dispatch_block_t)complete {
    [self removeCacheWithKey:key extraKey:nil complete:complete];
}

- (void)removeCacheWithKey:(NSString *)key
                  extraKey:(NSString *)extraKey
                  complete:(dispatch_block_t)complete {
    dispatch_async(self.opeartionQueue, ^{
        [self removeCacheWithKey:key extrakey:extraKey];
        dispatch_async_main(complete);
    });
}

- (id)dataWithKey:(NSString*)key {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (id)dataWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    NSAssert(NO, Default_Assert);
    return nil;
}

- (void)dataWithKey:(NSString*)key complete:(void(^)(__kindof id cacheData))complete {
    NSAssert(NO, Default_Assert);
}

- (void)dataWithKey:(NSString *)key
           extraKey:(NSString *)extraKey
           complete:(void (^)(__kindof id))complete {
    NSAssert(NO, Default_Assert);
}

@end
