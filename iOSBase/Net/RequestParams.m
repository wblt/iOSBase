//
//  RequestParams.m
//  Keepcaring
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RequestParams.h"

@interface RequestParams ()
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,copy)NSString *url;
@end

@implementation RequestParams
- (instancetype)initWithParams:(NSString *)url {
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
		_url = url;
    }
    return self;
}

- (void)addParameter:(NSString *)key value:(id)obj {
    if (obj == nil) {
        DLog(@"key:%@  value:%@ 值为空",key,obj);
        return;
    }
    [_dic setObject:obj forKey:key];
}

- (NSDictionary *)parameters {
    return _dic;
}

- (NSString *)url {
    return _url;
}
@end
