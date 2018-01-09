//
//  NetworkSingleton.h
//  meituan
//
//  Created by  15/6/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParams.h"
/**
 *  成功回调Block
 *
 *  @param data 返回的数据
 */
typedef void(^SuccessBlock)(id data);
/**
 *  失败回调Block
 *
 *  @param error 返回的数据
 */
typedef void(^FailureBlock)(NSError *error);
/**
 *  进度条
 *
 */
typedef void(^ProgressBlock)(CGFloat progress);
//请求方式
#define TIMEOUT 30
@interface NetworkSingleton : NSObject
/**
 *  创建单例对象
 *
 *  @return 返回创建的单例对象
 */
+ (NetworkSingleton *)shareInstace;



#pragma mark ###############新版本的请求方法#################
/**
 *  请求数据网络
 *
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
- (void)httpPost:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
    failureBlock:(FailureBlock)failureBlock;

/**
 *  请求数据网络
 *
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
- (void)httpGet:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
    failureBlock:(FailureBlock)failureBlock;

/**
 *  上传文件
 *
 *  @param files        文件信息
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (void)requestURL:(RequestParams *)requestParams
         withTitle:(NSString *)title
              file:(NSDictionary *)files
      successBlock:(SuccessBlock)successBlock
      failureBlock:(FailureBlock)failureBlock;

/**
 *  文件下载
 *
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (NSURLSessionDownloadTask *)download:(RequestParams *)requestParams withTitle:(NSString *)title progressBlock:(ProgressBlock)progressBlock successBlock:(SuccessBlock)successBlock
                          failureBlock:(FailureBlock)failureBlock;

/**
 *  请求数据网络 苹果原生
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
-(void)sessionPost:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
      failureBlock:(FailureBlock)failureBlock;

/**
 *  请求数据网络 苹果原生
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
-(void)sessionGet:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
     failureBlock:(FailureBlock)failureBlock;
@end
