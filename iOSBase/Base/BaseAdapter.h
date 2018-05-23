//
//  BaseAdapter.h
//  iOSBase
//
//  Created by wb on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DidSelectBlock)(id data);

@interface BaseAdapter : NSObject

@property(nonatomic,strong)NSMutableArray *datas;

- (void)setAdapter:(UITableView *)tableView;

- (void)addAll:(NSMutableArray *)t;

- (void)clear;

- (void)reloadData;

@end
