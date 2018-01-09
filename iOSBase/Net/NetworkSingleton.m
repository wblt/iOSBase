//
//  NetworkSingleton.m
//  meituan
//
//  Created by jinzelu on 15/6/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NetworkSingleton.h"
#import "AFNetworking.h"

static NetworkSingleton *instance = nil;
static AFHTTPSessionManager *manager;
@implementation NetworkSingleton
/**
 *  创建单例对象
 *
 *  @return 返回创建的单例对象
 */
+ (NetworkSingleton *)shareInstace {
    
    static dispatch_once_t onecToken = 0;
    
    dispatch_once(&onecToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (instance == nil) {
        instance = [super allocWithZone:zone];
    }
    return instance;
    
}

#pragma mark ###############新版本的请求方法#################
/**
 *  请求数据网络
 *
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
- (void)httpPost:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
    failureBlock:(FailureBlock)failureBlock {
    NSString *urlString = [requestParams url];
    NSDictionary *parmas = [requestParams parameters];
    // 1 拼接地址
    NSString *requestURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *requestURL = [baseUrl stringByAppendingString:ut8Str];
    // 3. 构造一个操作对象的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    // 这里要注意一下，不同的接口，我们在这里拼接一下可能会出错
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 统一打印参数
    DLog(@"%@地址：{{%@}}",title,urlString);
    if (parmas != nil) {
        NSArray *keysArray = [parmas allKeys];
        NSString *values = @"";
        for (int i = 0; i < keysArray.count; i++) {
            //根据键值处理字典中的每一项
            NSString *key = keysArray[i];
            NSString *value = parmas[key];
            values = [values stringByAppendingFormat:@"[key:%@ value:%@]",key,value];
        }
        DLog(@"%@参数:{{%@}}",title,values);
    }
    [SVProgressHUD showWithStatus:@"请稍后"];
    [manager POST:requestURL parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (successBlock) {
            DLog(@"%@成功返回:{{%@}}",title,responseObject);
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (failureBlock) {
            DLog(@"%@错误返回:{{%@}}",title,[error localizedDescription]);
            failureBlock(error);
        }
    }];
    
}

/**
 *  请求数据网络
 *
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
- (void)httpGet:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
   failureBlock:(FailureBlock)failureBlock {
    NSString *urlString = [requestParams url];
    // 1 拼接地址
    NSString *requestURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 3. 构造一个操作对象的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    // 这里要注意一下，不同的接口，我们在这里拼接一下可能会出错
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 统一打印参数
    DLog(@"%@地址：{{%@}}",title,urlString);
    [SVProgressHUD showWithStatus:@"请稍后"];
    [manager GET:requestURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (successBlock) {
            DLog(@"%@成功返回：{{%@}}",title,responseObject);
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (failureBlock) {
            DLog(@"%@错误返回：{{%@}}",title,[error localizedDescription]);
            failureBlock(error);
        }
    }];
}


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
      failureBlock:(FailureBlock)failureBlock
{
    NSDictionary *parmas = [requestParams parameters];
    NSString *urlString = [requestParams url];
    // 1 拼接地址
    NSString *requestURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 3. 构造一个操作对象的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    // 这里要注意一下，不同的接口，我们在这里拼接一下可能会出错
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg",nil];
    
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //请求
    if (files != nil) {
        // 统一打印参数
        DLog(@"%@地址：{{%@}}",title,urlString);
        if (parmas != nil) {
            NSArray *keysArray = [parmas allKeys];
            NSString *values = @"";
            for (int i = 0; i < keysArray.count; i++) {
                //根据键值处理字典中的每一项
                NSString *key = keysArray[i];
                NSString *value = parmas[key];
                values = [values stringByAppendingFormat:@"[key:%@ value:%@]",key,value];
            }
            DLog(@"%@参数：{{%@}}",title,values);
        }
        [SVProgressHUD showWithStatus:@"请稍后"];
        [manager POST:requestURL parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (id key in files) {
                id value = files[key];
                [formData appendPartWithFileData:value
                                            name:key
                                        fileName:@".jpg"
                                        mimeType:@"application/octet-stream"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //进度监听
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功
            if (successBlock) {
                [SVProgressHUD dismiss];
                DLog(@"%@成功返回：{{%@}}",title,responseObject);
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败
            if (failureBlock) {
                [SVProgressHUD dismiss];
                DLog(@"%@错误返回：{{%@}}",title,[error localizedDescription]);
                failureBlock(error);
            }
        }];
        
    }
}

/**
 *  文件下载
 *
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (NSURLSessionDownloadTask *)download:(RequestParams *)requestParams withTitle:(NSString *)title progressBlock:(ProgressBlock)progressBlock successBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSString *urlString = [requestParams url];
    NSString *urlS = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlS];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 统一打印参数
    DLog(@"%@地址：{{%@}}",title,urlString);
    [SVProgressHUD showWithStatus:@"请稍后"];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        CGFloat progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(progress);
            }
        });
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        NSString * suggestedFilename = response.suggestedFilename;
        NSString *downloadPath = [NSString stringWithFormat:@"%@/%@",DownloadFilePath,suggestedFilename];
        NSURL *fileURL = [NSURL fileURLWithPath:downloadPath];
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error == nil) {
            //下载成功
            if (successBlock) {
                [SVProgressHUD dismiss];
                DLog(@"%@成功返回：{{%@}}",title,filePath);
                successBlock(filePath);
            }
        }
        else {
            //下载失败
            if (failureBlock) {
                [SVProgressHUD dismiss];
                DLog(@"%@错误返回:{{%@}}",title,[error localizedDescription]);
                failureBlock(error);
            }
        }
    }];
    [task resume];
    return task;
}

/**
 *  请求数据网络 苹果原生
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
-(void)sessionGet:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
     failureBlock:(FailureBlock)failureBlock {
    NSString *urlString = [requestParams url];
    NSString *pathStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 30;
    NSURLSession *session = [NSURLSession sharedSession];
    // 统一打印参数
    DLog(@"%@地址：{{%@}}",title,urlString);
    [SVProgressHUD showWithStatus:@"请稍后"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                //请求成功
                if (successBlock) {
                    [SVProgressHUD dismiss];
                    DLog(@"%@成功返回:{{%@}}",title,data);
                    successBlock(data);
                }
            } else {
                //请求失败
                if (failureBlock) {
                    [SVProgressHUD dismiss];
                    DLog(@"%@错误返回:{{%@}}",title,[error localizedDescription]);
                    failureBlock(error);
                }
            }
        });
    }];
    [task resume];
}

/**
 *  请求数据网络 苹果原生
 *  @param successBlock 成功回调Block
 *  @param failureBlock 失败回调Block
 */
-(void)sessionPost:(RequestParams *)requestParams withTitle:(NSString *)title successBlock:(SuccessBlock)successBlock
      failureBlock:(FailureBlock)failureBlock {
    NSString *urlString = [requestParams url];
    NSDictionary *parmas = [requestParams parameters];
    NSString *pathStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSArray *allkeys = [parmas allKeys];
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in allkeys) {
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key,parmas[key]];
        [result appendString:str];
    }
    NSString *body = [result substringWithRange:NSMakeRange(0, result.length-1)];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    // 设置请求体
    [request setHTTPBody:bodyData];
    // 设置本次请求的提交数据格式
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 设置本次请求请求体的长度(因为服务器会根据你这个设定的长度去解析你的请求体中的参数内容)
    [request setValue:[NSString stringWithFormat:@"%ld",bodyData.length] forHTTPHeaderField:@"Content-Length"];
    // 设置本次请求的最长时间
    request.timeoutInterval = 30;
    NSURLSession *session = [NSURLSession sharedSession];
    // 统一打印参数
    DLog(@"%@地址：{{%@}}",title,urlString);
    if (parmas != nil) {
        NSArray *keysArray = [parmas allKeys];
        NSString *values = @"";
        for (int i = 0; i < keysArray.count; i++) {
            //根据键值处理字典中的每一项
            NSString *key = keysArray[i];
            NSString *value = parmas[key];
            values = [values stringByAppendingFormat:@"[key:%@ value:%@]",key,value];
        }
        DLog(@"%@参数:{{%@}}",title,values);
    }
    [SVProgressHUD showWithStatus:@"请稍后"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                //请求成功
                if (successBlock) {
                    [SVProgressHUD dismiss];
                    DLog(@"%@成功返回:{{%@}}",title,data);
                    successBlock(data);
                }
            } else {
                //请求失败
                if (failureBlock) {
                    [SVProgressHUD dismiss];
                     DLog(@"%@错误返回:{{%@}}",title,[error localizedDescription]);
                    failureBlock(error);
                }
            }
        });
    }];
    [task resume];
}
@end
