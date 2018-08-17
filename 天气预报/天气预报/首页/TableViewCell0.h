//
//  TableViewCell0.h
//  test
//
//  Created by 小哲的DELL on 2018/8/16.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface TableViewCell0 : UITableViewCell
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic, strong) Weather *weatherView;
@end
