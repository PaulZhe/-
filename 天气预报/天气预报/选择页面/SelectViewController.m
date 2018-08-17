//
//  SelectViewController.m
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/14.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "SelectTableViewCell.h"
#import "SelectViewController.h"
#import "SearchViewController.h"
#import "HomepageViewController.h"

@interface SelectViewController ()<UITableViewDelegate,UITableViewDataSource,SearchViewControllerDelegate>

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back1.jpg"]];
    
    //设置底部视图
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 692, 414, 44)];
    bottomView.backgroundColor = [UIColor clearColor];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    bottomButton.frame = CGRectMake(374, 7, 30, 30);
    [bottomButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomButton];
    [self.view addSubview:bottomView];
    
    //设置tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 414, 672) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SelectTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    //设置传递数组
    if(_passArray == nil){
        _passArray = [[NSMutableArray alloc] init];
    }
    if(_tmpArray == nil){
        _tmpArray = [[NSMutableArray alloc] init];
    }
    if(_timeArray == nil){
        _timeArray = [[NSMutableArray alloc] init];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _passArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.label1.text = _timeArray[indexPath.row];
    cell.label2.text = _passArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@°",_tmpArray[indexPath.row] ];
    cell.label3.text = str;
    
    return cell;
}

//设置选中Cell的响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    HomepageViewController *homepageViewController = [[HomepageViewController alloc]init];
    homepageViewController.receiveArray = _passArray;
    homepageViewController.page = indexPath.row;
    [self presentViewController:homepageViewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click{
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [self presentViewController:searchViewController animated:YES completion:nil];
    searchViewController.receiveArray = self.passArray;
    searchViewController.delegate = self;
}

- (void)pass:(NSMutableArray *)array{
    _passArray = array;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://free-api.heweather.com/s6/weather/now"]];
    
    
//    NSString *str = [[NSString alloc] init];
//    str = [_passArray[_passArray.count] stringByRemovingPercentEncoding];
    
    NSString *value =[NSString stringWithFormat:@"location=%@&key=c563861f72c649f2a698a472080eaa8c", _passArray[_passArray.count-1]];
    
    request.HTTPBody = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPMethod = @"POST";
    
    self.dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *str = [[NSString alloc] init];
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"update"] objectForKey:@"loc"];
        [self.timeArray addObject:str];
        
        str = [[[dic objectForKey:@"HeWeather6"][0] objectForKey:@"now"] objectForKey:@"tmp"];
        [self.tmpArray addObject:str];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    [_dataTask resume];
//    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
