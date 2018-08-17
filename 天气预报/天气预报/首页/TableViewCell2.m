//
//  TableViewCell2.m
//  test
//
//  Created by 小哲的DELL on 2018/8/15.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "TableViewCell2.h"

@implementation TableViewCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _label1 = [UILabel new];
        _label2 = [UILabel new];
        _label3 = [UILabel new];
        _label4 = [UILabel new];
        _label1.textColor = [UIColor colorWithRed:0.62f green:0.63f blue:0.65f alpha:1.00f];
        _label2.textColor = [UIColor colorWithRed:0.62f green:0.63f blue:0.65f alpha:1.00f];
        _label3.textColor = [UIColor whiteColor];
        _label4.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        _label1.font = [UIFont systemFontOfSize:15];
        _label2.font = [UIFont systemFontOfSize:15];
        _label3.font = [UIFont systemFontOfSize:26];
        _label4.font = [UIFont systemFontOfSize:26];
        
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label3];
        [self.contentView addSubview:self.label4];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _label1.frame = CGRectMake(20, 5, 80, 15);
    _label2.frame = CGRectMake(200, 5, 80, 15);
    _label3.frame = CGRectMake(20, 21, 190, 40);
    _label4.frame = CGRectMake(200, 21, 120, 40);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
