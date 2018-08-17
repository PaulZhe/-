//
//  TableView.h
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/14.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *requestArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) NSArray *array2;
@property (nonatomic, strong) NSArray *array3;
@property (nonatomic, strong) NSArray *array4;
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *weatherArray;
@property (nonatomic, strong) NSMutableArray *tmpArray;

@property (nonatomic, copy) NSString *cond_txt;//实况天气描述
@property (nonatomic, copy) NSString *tmp;//实时温度
@property (nonatomic, copy) NSString *date;//当天日期
@property (nonatomic, copy) NSString *tmp_max;
@property (nonatomic, copy) NSString *tmp_max2;
@property (nonatomic, copy) NSString *tmp_max3;//最高温度
@property (nonatomic, copy) NSString *tmp_min;
@property (nonatomic, copy) NSString *tmp_min2;
@property (nonatomic, copy) NSString *tmp_min3;//最低温度
@property (nonatomic, copy) NSString *cond_txt_d2;
@property (nonatomic, copy) NSString *cond_txt_d3;//图片代码3
@property (nonatomic, copy) NSString *txt;//生活指数详细描述
@property (nonatomic, copy) NSString *sr;//日出
@property (nonatomic, copy) NSString *ss;//日落
@property (nonatomic, copy) NSString *pop;//降水概率
@property (nonatomic, copy) NSString *hum;//湿度
@property (nonatomic, copy) NSString *wind_dir;//风向
@property (nonatomic, copy) NSString *wind_spd;//风速，公里/小时
@property (nonatomic, copy) NSString *fl;//体感温度
@property (nonatomic, copy) NSString *pcpn;//降水量
@property (nonatomic, copy) NSString *pres;//气压
@property (nonatomic, copy) NSString *vis;//能见度
@property (nonatomic, copy) NSString *uv_index;//紫外线指数
@property (nonatomic, copy) NSString *place;

- (void)setRequestArray:(NSMutableArray *)requestArray page:(int)page;
@end
