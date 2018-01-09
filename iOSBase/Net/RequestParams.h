//
//  RequestParams.h
//  Keepcaring
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParams : NSObject
- (instancetype)initWithParams:(NSString *)url;

- (void)addParameter:(NSString *)key value:(id)obj;

- (NSDictionary *)parameters;

- (NSString *)url;
@end
