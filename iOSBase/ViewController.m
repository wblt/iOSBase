//
//  ViewController.m
//  iOSBase
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "RowsBean.h"
#import "ShopBean.h"
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *rowsArry;
@property(nonatomic,strong)NSMutableArray *shopsArray;
@property(nonatomic,assign)NSInteger rowindex;
@property(nonatomic,assign)NSInteger shopindex;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bg_setDisableCloseDB(YES);
    self.rowsArry = [NSMutableArray array];
    RequestParams *parmss = [[RequestParams alloc] initWithParams:@"https://niu.souche.com/filter_screening?parameter=area&parent_code=02272&national=0"];
    [[NetworkSingleton shareInstace] httpGet:parmss withTitle:@"" successBlock:^(id data) {
        NSDictionary *da = data[@"data"];
        NSArray *selectlist = da[@"select_list"];
        NSDictionary *dic = [selectlist firstObject];
        self.rowsArry = [RowsBean mj_objectArrayWithKeyValuesArray:dic[@"rows"]];
        self.rowindex = 1;
        [self handlerShop];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)handlerShop {
    if (self.rowindex >=self.rowsArry.count) {
        return;
    }
    RowsBean *bean = self.rowsArry[self.rowindex];
    [self shop: bean.code];
}

- (void)shop:(NSString *)idd {
    NSString *urlstr = [NSString stringWithFormat:@"https://niu.souche.com/yellowpage/shops?token=02_yxuR_eL4M981dB2&id=%@-0&page=1&size=1024",idd];
    RequestParams *parmss = [[RequestParams alloc] initWithParams:urlstr];
    [[NetworkSingleton shareInstace] httpGet:parmss withTitle:@"" successBlock:^(id data) {
        NSDictionary *da = data[@"data"];
        self.shopsArray = [ShopBean mj_objectArrayWithKeyValuesArray:da[@"list"]];
        self.shopindex = 0;
        self.rowindex = self.rowindex +1;
        [self handlerSearch];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)handlerSearch {
    if (self.shopindex == self.shopsArray.count) {
        // 返回上一级
        [self handlerShop];
    } else {
        ShopBean *bean = self.shopsArray[self.shopindex];
        [self serach:bean.shop_name];
    }
}

- (void)serach:(NSString *)keywords {
    NSString *urlstr = [NSString stringWithFormat:@"https://niu.souche.com/yellowpage?token=02_yxuR_eL4M981dB2&keyword=%@&parameter=&page=1&size=20&first=1",keywords];
    RequestParams *parmss = [[RequestParams alloc] initWithParams:urlstr];
    [[NetworkSingleton shareInstace] httpGet:parmss withTitle:@"" successBlock:^(id data) {
        NSDictionary *da = data[@"data"];
        NSMutableArray *sreachArr = [ShopBean mj_objectArrayWithKeyValuesArray:da[@"list"]];
        for (ShopBean *bean in sreachArr) {
            if ([keywords isEqualToString:bean.shop_name]) {
                NSLog(@"商店：%@,联系人：%@,电话：%@",bean.shop_name,bean.user_name,bean.user_mobile);
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.shopindex = self.shopindex + 1;
                [self handlerSearch];
            });
        });
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
