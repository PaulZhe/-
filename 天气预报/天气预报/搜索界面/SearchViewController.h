//
//  SearchViewController.h
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/14.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
//设置代理
@class SearchViewController;
@protocol SearchViewControllerDelegate <NSObject>
- (void)pass:(NSMutableArray*)array;
@end

@interface SearchViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSMutableArray *receiveArray;

@property(nonatomic, weak)id <SearchViewControllerDelegate> delegate;
@end
