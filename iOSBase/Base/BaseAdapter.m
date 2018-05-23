//
//  BaseAdapter.m
//  iOSBase
//
//  Created by wb on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseAdapter.h"
@interface BaseAdapter ()
@property(nonatomic,strong)UITableView *tableview;
@end
@implementation BaseAdapter
- (instancetype)init {
    self = [super init];
    if (self) {
        _datas = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addAll:(NSMutableArray *)t {
    [self.datas addObjectsFromArray:t];
}

- (void)clear {
    [self.datas removeAllObjects];
}

- (void)reloadData {
    [self.tableview reloadData];
}

- (void)setAdapter:(UITableView *)tableView {
    self.tableview = tableView;
}
@end
