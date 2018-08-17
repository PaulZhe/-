//
//  SelectViewController.h
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/14.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UIViewController

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *passArray;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSMutableArray *tmpArray;
@property (nonatomic, strong) NSMutableArray *timeArray;

@end
