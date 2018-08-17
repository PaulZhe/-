//
//  TableView.m
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/14.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "TableView.h"
#import "TableViewCell1.h"
#import "TableViewCell2.h"
#import "Weather.h"

@implementation TableView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        // Do any additional setup after loading the view, typically from a nib.

        _array1 = [[NSArray alloc] initWithObjects:@"日出", @"降雨概率", @"风速", @"降雨量", @"能见度", nil];
        _array2 = [[NSArray alloc] initWithObjects:@"日落", @"湿度", @"体感温度", @"气压", @"紫外线度数", nil];
        
        //初始化传值字符串
        if (!_cond_txt) {
            _cond_txt = [NSString new];//实况天气描述
        }
        if (!_tmp) {
            _tmp = [NSString new];//实时温度
        }
        if (!_date) {
            _date = [NSString new];//当天日期
        }
        if (!_tmp_max) {
            _tmp_max = [NSString new];
        }
        if (!_tmp_max2) {
            _tmp_max2 = [NSString new];
        }
        if (!_tmp_max3) {
            _tmp_max3 = [NSString new];//最高温度
        }
        if (!_tmp_min) {
            _tmp_min = [NSString new];
        }
        if (!_tmp_min2) {
            _tmp_min2 = [NSString new];
        }
        if (!_tmp_min3) {
            _tmp_min3 = [NSString new];
        }
        if (!_cond_txt_d2) {
            _cond_txt_d2 = [NSString new];
        }
        if (!_cond_txt_d3) {
            _cond_txt_d3 = [NSString new];//图片代码3
        }
        if (!_txt) {
            _txt = [NSString new];//生活指数详细描述
        }
        if (!_sr) {
            _sr = [NSString new];//日出
        }
        if (!_ss) {
            _ss = [NSString new];//日落
        }
        if (!_pop) {
             _pop = [NSString new];//降水概率
        }
        if (!_hum) {
            _hum = [NSString new];//湿度
        }
        if (!_wind_dir) {
            _wind_dir = [NSString new];//风向
        }
        if (!_wind_spd) {
            _wind_spd = [NSString new];//风速，公里/小时
        }
        if (!_fl) {
            _fl = [NSString new];//体感温度
        }
        if (!_pcpn) {
            _pcpn = [NSString new];//降水量
        }
        if (!_pres) {
            _pres = [NSString new];//气压
        }
        if (!_vis) {
            _vis = [NSString new];//能见度
        }
        if (!_uv_index) {
            _uv_index = [NSString new];//紫外线指数
        }
        if (!_place) {
            _place = [NSString new];//紫外线指数
        }
        
        if (!self.timeArray) {
            self.timeArray = [[NSMutableArray alloc] init];
        }
        if (!self.weatherArray) {
            self.weatherArray = [[NSMutableArray alloc] init];
        }
        if (!self.tmpArray) {
            self.tmpArray = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.tableView.frame = CGRectMake(0, 0, 414, 672);
}

//传递数组
- (void)setRequestArray:(NSMutableArray *)requestArray page:(int)page{
    _requestArray = requestArray;
    
    self.place = requestArray[page];
    
    //接口2
    NSURLSession *session2 = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.jisuapi.com/weather/query"]];
    
    NSString *value2 =[NSString stringWithFormat:@"appkey=50c4a75024a1ea97&city=%@", _requestArray[page]];
    
    request2.HTTPBody = [value2 dataUsingEncoding:NSUTF8StringEncoding];
    
    request2.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *dataTask2;
    
    dataTask2 = [session2 dataTaskWithRequest:request2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *str = [[NSString alloc] init];

        for (int i = 0; i < 24; i++) {
            str = [[[dic objectForKey:@"result"] objectForKey:@"hourly"][i] objectForKey:@"time"];
            [self.timeArray addObject:str];
            str = [[[dic objectForKey:@"result"] objectForKey:@"hourly"][i] objectForKey:@"weather"];
            [self.weatherArray addObject:str];
            str = [[[dic objectForKey:@"result"] objectForKey:@"hourly"][i] objectForKey:@"temp"];
            [self.tmpArray addObject:str];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.tableView == nil){
                self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 672) style:UITableViewStyleGrouped];
                //注册自定义cell
                [self.tableView registerClass:[TableViewCell1 class] forCellReuseIdentifier:@"cell2"];
                [self.tableView registerClass:[TableViewCell2 class] forCellReuseIdentifier:@"cell4"];
                
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                self.tableView.backgroundColor = [UIColor clearColor];
                [self addSubview:self.tableView];
            }
        });
    }];
    [dataTask2 resume];
    
    //接口1
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://free-api.heweather.com/s6/weather"]];
    
    NSString *value =[NSString stringWithFormat:@"location=%@&key=c563861f72c649f2a698a472080eaa8c", _requestArray[page]];
    
    request.HTTPBody = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPMethod = @"POST";
    
    self.dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *str = [[NSString alloc] init];
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"cond_txt"];
        self.cond_txt = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"wind_dir"];
        self.wind_dir = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"wind_spd"];
        self.wind_spd = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"hum"];
        self.hum = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"pcpn"];
        self.pcpn = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"pres"];
        self.pres = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"vis"];
        self.vis = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"tmp"];
        self.tmp = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"fl"];
        self.fl = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][1] objectForKey:@"cond_txt_d"];
        self.cond_txt_d2 = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][1] objectForKey:@"tmp_max"];
        self.tmp_max2 = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][1] objectForKey:@"tmp_min"];
        self.tmp_min2 = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][2] objectForKey:@"cond_txt_d"];
        self.cond_txt_d3 = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][2] objectForKey:@"tmp_max"];
        self.tmp_max3 = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][2] objectForKey:@"tmp_min"];
        self.tmp_min3 = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"tmp_max"];
        self.tmp_max = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"tmp_min"];
        self.tmp_min = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"date"];
        self.date = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"ss"];
        self.ss = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"sr"];
        self.sr = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"pop"];
        self.pop = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"daily_forecast"][0] objectForKey:@"uv_index"];
        self.uv_index = str;
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"lifestyle"][0] objectForKey:@"txt"];
        self.txt = str;
        
        NSString *str1 = [NSString stringWithFormat:@"%@ %@km/h",self.wind_dir,self.wind_spd];
        self.array3 = [[NSArray alloc] initWithObjects:self.sr, self.pop, str1, self.pcpn, self.vis,  nil];
        NSString *str2 = [NSString stringWithFormat:@"%@百帕",self.pres];
        self.array4 = [[NSArray alloc] initWithObjects:self.ss, self.hum, self.fl, str2, self.uv_index, nil];
        
        
        
    }];
    [_dataTask resume];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 4){
        return 5;
    } else if(section == 2){
        return 2;
    } else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 314;
    } else if(indexPath.section == 1){
        return 153;
    } else if(indexPath.section == 2){
        return 46;
    } else if(indexPath.section == 3){
        return 74;
    } else{
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        UITableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if(cell0 == nil){
            cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
            cell0.backgroundColor = [UIColor clearColor];
            cell0.contentView.backgroundColor = [UIColor clearColor];
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(140, 60, 134, 32)];
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(172, 100, 70, 20)];
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(112, 145, 190, 74)];
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 275, 140, 25)];
            UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(150, 279, 40, 20)];
            UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(290, 275, 40, 25)];
            UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(360, 275, 40, 25)];
            label1.textAlignment = NSTextAlignmentCenter;
            label2.textAlignment = NSTextAlignmentCenter;
            label3.textAlignment = NSTextAlignmentCenter;
            label1.font = [UIFont systemFontOfSize:36];
            label2.font = [UIFont systemFontOfSize:19];
            label3.font = [UIFont systemFontOfSize:96];
            label4.font = [UIFont systemFontOfSize:23];
            label5.font = [UIFont systemFontOfSize:18];
            label6.font = [UIFont systemFontOfSize:23];
            label7.font = [UIFont systemFontOfSize:23];
            label1.textColor = [UIColor whiteColor];
            label2.textColor = [UIColor whiteColor];
            label3.textColor = [UIColor whiteColor];
            label4.textColor = [UIColor whiteColor];
            label5.textColor = [UIColor whiteColor];
            label6.textColor = [UIColor whiteColor];
            label7.textColor = [UIColor colorWithRed:0.62f green:0.63f blue:0.65f alpha:1.00f];
            label1.text = self.place;
            label2.text = self.cond_txt;
            NSString *str = [NSString stringWithFormat:@"%@°",self.tmp];
            label3.text = str;
            label4.text = self.date;
            label5.text =@"今天";
            label6.text = self.tmp_max;
            label7.text = self.tmp_min;
            [cell0.contentView addSubview:label1];
            [cell0.contentView addSubview:label2];
            [cell0.contentView addSubview:label3];
            [cell0.contentView addSubview:label4];
            [cell0.contentView addSubview:label5];
            [cell0.contentView addSubview:label6];
            [cell0.contentView addSubview:label7];
        }
        return cell0;
    } else if(indexPath.section == 1){
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell1 == nil){
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 153)];
            scrollView.contentSize = CGSizeMake(90*24, 0);
            scrollView.bounces = NO;
            scrollView.backgroundColor = [UIColor clearColor];
            cell1.backgroundColor = [UIColor clearColor];
            cell1.contentView.backgroundColor = [UIColor clearColor];
            for (int i = 0; i < 24; i++) {
                Weather *weatherView = [[Weather alloc] initWithFrame:CGRectMake(90*i, 0, 90, 153)];
                weatherView.label.text = self.timeArray[i];
                UIImage *image = [UIImage imageNamed:self.weatherArray[i]];
                weatherView.imageView.image = image;
                weatherView.label1.text = self.tmpArray[i];
                [scrollView addSubview:weatherView];
            }
            [cell1.contentView addSubview:scrollView];
        }
        return cell1;
    } else if(indexPath.section == 2){
        TableViewCell1 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell2.label1.text = @"明天";
            cell2.label2.text = _tmp_max2;
            cell2.label3.text = _tmp_min2;
            NSString *str = [NSString stringWithFormat:@"%@",_cond_txt_d2];
            cell2.imageViewz.image = [UIImage imageNamed:str];
            
        } else{
            cell2.label1.text = @"后天";
            cell2.label2.text = _tmp_max3;
            cell2.label3.text = _tmp_min3;
            NSString *str = [NSString stringWithFormat:@"%@",_cond_txt_d3];
            cell2.imageViewz.image = [UIImage imageNamed:str];
        }
        return cell2;
    } else if(indexPath.section == 3){
        
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if(cell3 == nil){
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            cell3.backgroundColor = [UIColor clearColor];
            cell3.contentView.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 376, 44)];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            label.text = self.txt;
            label.font = [UIFont systemFontOfSize:17];
            [cell3.contentView addSubview:label];
        }
        return cell3;
    } else{
        TableViewCell2 *cell4 = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        cell4.label1.text = self.array1[indexPath.row];
        cell4.label2.text = self.array2[indexPath.row];
        cell4.label3.text = self.array3[indexPath.row];
        cell4.label4.text = self.array4[indexPath.row];
        return cell4;
    }
}

//设置选中Cell的响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

@end
