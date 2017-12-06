//
//  TImageCacheService.m
//  TagQ
//
//  Created by 李浩 on 2017/4/1.
//  Copyright © 2017年 Genius. All rights reserved.
//

#import "TImageCacheService.h"
#import <TMarco/TMarco.h>
#import <FHCategory/FHCategory.h>

@implementation TImageCacheService

+ (instancetype)cacheServiceWithPath:(NSString *)cachePath {
    return [self cacheServiceWithPath:cachePath runQueue:nil];
}

+ (instancetype)cacheServiceWithPath:(NSString *)cachePath runQueue:(dispatch_queue_t)queue {
    NSString* cache_path = cachePath ? [cachePath copy] : [kPathCache stringByAppendingPathComponent:@"default"];
    dispatch_queue_t run_queue = queue ? queue : dispatch_queue_create("com.image.cacheService", DISPATCH_QUEUE_SERIAL);
    TImageCacheService* cacheService = [[TImageCacheService alloc] initWithCachePath:cache_path runQueue:run_queue];
    return cacheService;
}

- (NSString*)cacheKeyWithString:(NSString *)str {
    return [self cacheKeyWithString:str extraKey:nil];
}

- (NSString*)cacheKeyWithString:(NSString *)str extraKey:(NSString *)extraKey {
    return [[[str stringByAppendingString:extraKey?extraKey:@""] fh_md5String] stringByAppendingString:@".png"];
}

- (NSString*)cachePathWithKey:(NSString*)key {
    return [self cachePathWithKey:key extraKey:nil];
}

- (NSString*)cachePathWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    return [self.cachePath stringByAppendingPathComponent:[self cacheKeyWithString:key extraKey:extraKey]];
}

- (NSString *)cacheRelativePathWithKey:(NSString *)key {
    return [self cacheRelativePathWithKey:key extraKey:nil];
}

- (NSString *)cacheRelativePathWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    return [@"default" stringByAppendingString:[self cacheKeyWithString:key extraKey:extraKey]];
}

- (void)cacheData:(id)data key:(NSString *)key {
    [self cacheData:data key:key quality:1.0];
}

- (void)cacheData:(id)data key:(NSString *)key extraKey:(NSString *)extraKey {
    [self cacheData:data key:key extrakey:extraKey quality:1.0];
}

- (void)cacheData:(id)data key:(NSString *)key quality:(CGFloat)quality {
    [self cacheData:data key:key extrakey:nil quality:quality];
}

- (void)cacheData:(id)data
              key:(NSString *)key
         extrakey:(NSString *)extraKey
          quality:(CGFloat)quality {
    NSParameterAssert(data);
    NSParameterAssert(key);
    if ([data isKindOfClass:@classify(UIImage)]) {
        data = UIImageJPEGRepresentation(T_ClassForceify(data, UIImage), quality);
    }
    NSAssert(isKindofClass(data, NSData), @"缓存对象不为NSData");
    [T_ClassForceify(data, NSData) writeToFile:[self cachePathWithKey:key extraKey:extraKey] atomically:YES];
}

- (void)cacheData:(id)data key:(NSString *)key complete:(dispatch_block_t)complete {
    [self cacheData:data key:key quality:1.0 complete:complete];
}

- (void)cacheData:(id)data
              key:(NSString *)key
         extraKey:(NSString *)extraKey
         complete:(dispatch_block_t)complete {
    [self cacheData:data key:key extraKey:extraKey quality:1.0 complete:complete];
}

- (void)cacheData:(id)data
              key:(NSString *)key
          quality:(CGFloat)quality
         complete:(dispatch_block_t)complete {
    [self cacheData:data key:key extraKey:nil quality:quality complete:complete];
}

- (void)cacheData:(id)data
              key:(NSString *)key
         extraKey:(NSString *)extraKey
          quality:(CGFloat)quality
         complete:(dispatch_block_t)complete {
    dispatch_async(self.opeartionQueue, ^{
        [self cacheData:data key:key extrakey:extraKey quality:quality];
        dispatch_async_main(complete);
    });
}

- (UIImage*)dataWithKey:(NSString *)key {
    return [self dataWithKey:key extraKey:nil];
}

- (UIImage*)dataWithKey:(NSString *)key extraKey:(NSString *)extraKey {
    NSString* filePath = [self cachePathWithKey:key extraKey:extraKey];
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
}

- (void)dataWithKey:(NSString *)key complete:(void (^)(__kindof id))complete {
    [self dataWithKey:key extraKey:nil complete:complete];
}

- (void)dataWithKey:(NSString *)key
           extraKey:(NSString *)extraKey
           complete:(void (^)(__kindof id))complete {
    dispatch_async(self.opeartionQueue, ^{
        UIImage* image = [self dataWithKey:key extraKey:extraKey];
        dispatch_async_main(^{
            !complete?:complete(image);
        });
    });
}

@end
