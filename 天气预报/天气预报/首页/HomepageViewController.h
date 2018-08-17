//
//  HomepageViewController.h
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/13.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageViewController : UIViewController

@property(nonatomic,strong) UITableView *tableView;
@property (strong,nonatomic)UIScrollView *scrollview; //滚动视图控件对象
@property (strong,nonatomic)UIPageControl *pagecontrol;//分页控制控件对象
@property (strong,nonatomic)NSMutableArray *receiveArray;
@property (nonatomic) NSInteger page;

@end
