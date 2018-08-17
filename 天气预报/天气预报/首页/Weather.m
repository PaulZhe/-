//
//  Weather.m
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/16.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        // Do any additional setup after loading the view, typically from a nib.
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:19];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _label1 = [[UILabel alloc] init];
        _label1.font = [UIFont systemFontOfSize:19];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.textColor = [UIColor whiteColor];
        [self addSubview:_label1];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = CGRectMake(10, 15, 70, 22);
    _label1.frame = CGRectMake(10, 107, 70, 22);
    _imageView.frame = CGRectMake(27, 57, 34, 34);
}


@end
