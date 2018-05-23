//
//  BaseViewController.m
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<CQPlaceholderViewDelegate>

@property (nonatomic,strong) UIImageView* noDataView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**<设置导航栏背景颜色*/
    self.navigationController.navigationBar.barTintColor = UIColorFromHex(0x13CBF7);//68c14a
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]}];
}

-(void)showNoDataImage
{
    _noDataView=[[UIImageView alloc] init];
    [_noDataView setImage:[UIImage imageNamed:@"generl_nodata"]];
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [_noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
            [obj addSubview:_noDataView];
        }
    }];
}

-(void)removeNoDataImage{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

- (void)reloadViewData {
	
}

#pragma mark - Delegate - 占位图
/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(CQPlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender{
	switch (placeholderView.type) {
		case CQPlaceholderViewTypeNoGoods:       // 没商品
		{
			//[self.view makeToast:@"买个球啊"];
		}
			break;
			
		case CQPlaceholderViewTypeNoOrder:       // 没有订单
		{
			//[self.view makeToast:@"拉到就拉到"];
		}
			break;
			
		case CQPlaceholderViewTypeNoNetwork:     // 没网
		{
			//[self.view makeToast:@"没网适合打排位"];
		}
			break;
			
		case CQPlaceholderViewTypeBeautifulGirl: // 妹纸
		{
			//[self.view makeToast:@"哦，那你很棒棒哦"];
		}
			break;
			
		default:
			break;
	}
	// 重新加载页面
	[self reloadViewData];
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
