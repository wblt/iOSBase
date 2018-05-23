//
//  TestViewController.m
//  iOSBase
//
//  Created by wb on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestViewController.h"
#import "TestAdapter.h"
#import "TestModel.h"
@interface TestViewController ()
@property(nonatomic,strong) TestAdapter *adapter;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试";
    [self initview];
}

- (void)initview {
    UITableView *tableView = UITableView.new;
    [self.view addSubview:tableView];
    tableView.sd_layout.leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view,0);
    // 设置适配器
    self.adapter = [[TestAdapter alloc] init];
    [self.adapter setAdapter:tableView];
    self.adapter.selectBlock = ^(UITableView *tableView, NSObject *b, NSIndexPath *p) {
        [SVProgressHUD showInfoWithStatus:@"点击"];
    };
    
    // 设置数据
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        TestModel *test = [[TestModel alloc] init];
        [test setTitle:@"我是一条cell"];
        [datas addObject:test];
    }
    [self.adapter addAll:datas];
    [self.adapter reloadData];
//    if (self.adapter.datas.count == 0) {
//        // 有tabbar 的情况
//        self.placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) type:CQPlaceholderViewTypeBeautifulGirl delegate:self];
//        [tableView addSubview:self.placeholderView];
//    }
}

- (void)reloadViewData {
	// 设置数据
	NSMutableArray *datas = [NSMutableArray array];
	for (int i = 0; i<10; i++) {
		TestModel *test = [[TestModel alloc] init];
		[test setTitle:@"我是一条cell"];
		[datas addObject:test];
	}
	[self.adapter addAll:datas];
	[self.adapter reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
