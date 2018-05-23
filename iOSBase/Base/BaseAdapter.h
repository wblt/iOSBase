//
//  BaseAdapter.h
//  iOSBase
//
//  Created by wb on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DidSelectBlock)(UITableView *tableView,NSObject *b,NSIndexPath *p);

@interface BaseAdapter : NSObject

@property(nonatomic,strong)NSMutableArray *datas;

@property(nonatomic, copy) DidSelectBlock selectBlock;

- (void)setAdapter:(UITableView *)tableView;

- (void)addAll:(NSMutableArray *)t;

- (void)clear;

- (void)reloadData;

@end
