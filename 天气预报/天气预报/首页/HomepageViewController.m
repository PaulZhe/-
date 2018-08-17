//
//  HomepageViewController.m
//  天气预报
//
//  Created by 小哲的DELL on 2018/8/13.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "HomepageViewController.h"
#import "TableView.h"

@interface HomepageViewController ()<UIScrollViewDelegate>

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    //设置底部视图
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 692, 414, 44)];
    bottomView.backgroundColor = [UIColor clearColor];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    bottomButton.frame = CGRectMake(374, 7, 30, 30);
    [bottomButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomButton];
    [self.view addSubview:bottomView];
    
    //初始化传值数组
    if(_receiveArray == nil){
        _receiveArray = [[NSMutableArray alloc] init];
    }
    
    //创建ScrollView
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 672)];

    //设置scrollView
    self.scrollview.contentSize = CGSizeMake(_receiveArray.count*self.view.frame.size.width, 0);
    self.scrollview.contentOffset = CGPointMake((self.page)*self.view.frame.size.width, 0);//默认滚动视图的初始原点位置都为0
    self.scrollview.pagingEnabled = YES;//设置滚动视图可以进行分页
    self.scrollview.directionalLockEnabled = YES;
    self.scrollview.bounces = NO;

    self.scrollview.delegate = self;//设置滚动视图的代理
    self.scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    for(int i = 0; i < _receiveArray.count; i++){
        TableView *view = [[TableView alloc] initWithFrame:CGRectMake(414*i, 0, 414, 672)];
        
        [view setRequestArray:_receiveArray page:i];
        [self.scrollview addSubview:view];
    }
    
    [self.view addSubview:self.scrollview];
    
    //创建初始化并设置PageControl
    self.pagecontrol = [[UIPageControl alloc]init];
    self.pagecontrol.frame = CGRectMake(157, 7, 100, 30);
    self.pagecontrol.numberOfPages = _receiveArray.count;
    self.pagecontrol.currentPage  = self.page; //默认第一页页数为0
    //设置分页控制点颜色
//    self.pagecontrol.pageIndicatorTintColor = [UIColor redColor];//未选中的颜色
//    self.pagecontrol.currentPageIndicatorTintColor = [UIColor greenColor];//选中时的颜色
    //添加分页控制事件用来分页
    [self.pagecontrol addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    //将分页控制视图添加到视图控制器视图中
    [bottomView addSubview:self.pagecontrol];
    self.view.backgroundColor = [UIColor clearColor];


}

#pragma mark - pageControll的事件响应
-(void)pageControlChanged:(UIPageControl*)sender
{
    
     NSLog(@"%ld",sender.currentPage);
     CGRect frame;
     frame.origin.x = self.scrollview.frame.size.width * sender.currentPage;
     frame.origin.y = 0;
     frame.size = self.scrollview.frame.size;
     [self.scrollview scrollRectToVisible:frame animated:YES];
    
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算pagecontroll相应地页(滚动视图可以滚动的总宽度/单个滚动视图的宽度=滚动视图的页数)
    NSInteger currentPage = (int)(scrollView.contentOffset.x) / (int)(self.view.frame.size.width);
    self.pagecontrol.currentPage = currentPage;//将上述的滚动视图页数重新赋给当前视图页数,进行分页
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)click{
    [self dismissViewControllerAnimated:YES completion:nil];
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
