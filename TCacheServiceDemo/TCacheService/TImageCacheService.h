//
//  TImageCacheService.h
//  TagQ
//
//  Created by 李浩 on 2017/4/1.
//  Copyright © 2017年 Genius. All rights reserved.
//

#import "TCacheService.h"
#import <CoreGraphics/CoreGraphics.h>

@interface TImageCacheService : TCacheService

/**
 缓存图片

 @param data 要缓存的图片可以是UIImage和NSData
 @param key 缓存的Key
 @param quality 压缩质量
 */
- (void)cacheData:(id)data
              key:(NSString *)key
          quality:(CGFloat)quality;

/**
 缓存图片

 @param data 同上
 @param key 同上
 @param extraKey 额外的key
 @param quality 同上
 */
- (void)cacheData:(id)data
              key:(NSString *)key
         extrakey:(NSString*)extraKey
          quality:(CGFloat)quality;

/**
 异步缓存

 @param data 同上
 @param key 同上
 @param quality 同上
 @param complete 缓存完成时的回调,会回到主线程
 */
- (void)cacheData:(id)data
              key:(NSString *)key
          quality:(CGFloat)quality
         complete:(dispatch_block_t)complete;

- (void)cacheData:(id)data
              key:(NSString *)key
         extraKey:(NSString*)extraKey
          quality:(CGFloat)quality
         complete:(dispatch_block_t)complete;

@end
