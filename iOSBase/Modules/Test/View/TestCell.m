//
//  TestCell.m
//  iOSBase
//
//  Created by wb on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell {
    UILabel *_title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initview];
    }
    return self;
}

- (void)initview {
    _title = UILabel.new;
    [self.contentView addSubview: _title];
    _title.sd_layout.leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
}

- (void)setModel:(TestModel *)model {
    [_title setText:model.title];
}
@end
