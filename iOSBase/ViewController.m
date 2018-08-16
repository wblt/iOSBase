//
//  ViewController.m
//  iOSBase
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RequestParams *parmss = [[RequestParams alloc] initWithParams:@"http://192.168.0.196:8101/A801/oauth/token"];
    [parmss addParameter:@"grant_type" value:@"password"];
    [parmss addParameter:@"username" value:@"10002"];
    [parmss addParameter:@"password" value:@"123456"];
    [parmss addParameter:@"scope" value:@"k12api"];
    [parmss addParameter:@"client_id" value:@"k12-123456"];
    [parmss addParameter:@"client_secret" value:@"654321"];
    [[NetworkSingleton shareInstace] httpPost:parmss withTitle:@"请求token" successBlock:^(id data) {
        
    } failureBlock:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
