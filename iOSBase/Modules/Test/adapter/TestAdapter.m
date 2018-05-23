//
//  TestAdapter.m
//  iOSBase
//
//  Created by wb on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestAdapter.h"
#import "TestCell.h"
@interface TestAdapter ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)UITableView *tableview;
@end
@implementation TestAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        _datas = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setAdapter:(UITableView *)tableView {
    self.tableview = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    if (cell == nil) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
    }
    [cell setModel:self.datas[indexPath.row]];
    return cell;
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

@end
