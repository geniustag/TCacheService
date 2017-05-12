//
//  TCacheService.h
//  TagQ
//
//  Created by 李浩 on 2017/4/3.
//  Copyright © 2017年 Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCacheService : NSObject

@property (nonatomic,copy,readonly) NSString* cachePath;

@property (nonatomic,readonly) dispatch_queue_t opeartionQueue;

+ (instancetype)cacheServiceWithPath:(NSString*)cachePath;

+ (instancetype)cacheServiceWithPath:(NSString *)cachePath runQueue:(dispatch_queue_t)queue;

- (instancetype)initWithCachePath:(NSString*)cachePath runQueue:(dispatch_queue_t)queue;

- (NSString*)cacheKeyWithString:(NSString*)str;

- (NSString*)cacheKeyWithString:(NSString *)str extraKey:(NSString*)extraKey;

- (NSString*)cachePathWithKey:(NSString*)key;

- (NSString*)cachePathWithKey:(NSString *)key extraKey:(NSString*)extraKey;

- (void)cacheData:(id)data key:(NSString*)key;

- (void)cacheData:(id)data key:(NSString *)key extraKey:(NSString*)extraKey;

- (void)cacheData:(id)data
                      key:(NSString *)key
                 complete:(dispatch_block_t)complete;

- (void)cacheData:(id)data
              key:(NSString *)key
         extraKey:(NSString*)extraKey
         complete:(dispatch_block_t)complete;

- (void)removeCacheWithKey:(NSString*)key;

- (void)removeCacheWithKey:(NSString *)key extrakey:(NSString*)extraKey;

- (void)removeCacheWithKey:(NSString *)key complete:(dispatch_block_t)complete;

- (void)removeCacheWithKey:(NSString *)key
                  extraKey:(NSString*)extraKey
                  complete:(dispatch_block_t)complete;

- (id)dataWithKey:(NSString*)key;

- (id)dataWithKey:(NSString *)key extraKey:(NSString*)extraKey;

- (void)dataWithKey:(NSString*)key complete:(void(^)(__kindof id cacheData))complete;

- (void)dataWithKey:(NSString *)key
           extraKey:(NSString*)extraKey
           complete:(void (^)(__kindof id))complete;

@end
