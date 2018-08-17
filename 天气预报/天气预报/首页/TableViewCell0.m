//
//  TableViewCell0.m
//  test
//
//  Created by 小哲的DELL on 2018/8/16.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "TableViewCell0.h"
#import "Weather.h"

@implementation TableViewCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(90*24, 0);
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        for (int i = 0; i < 24; i++) {
            self.weatherView = [[Weather alloc] initWithFrame:CGRectMake(90*i, 0, 90, 153)];
            [_scrollView addSubview:self.weatherView];
        }
        
        [self.contentView addSubview:_scrollView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, 414, 153);
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
