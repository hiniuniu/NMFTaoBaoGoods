//
//  DetailViewController.m
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import "DetailViewController.h"




@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *OneTable;
    UITableView *TwoTable;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    /** 底层view*/
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.scrollEnabled = NO;
    mainScrollView.frame = CGRectMake(0, 0, kWidth, kHeight);
    mainScrollView.contentSize = CGSizeMake(kWidth, kHeight * 2);
    mainScrollView.backgroundColor = [UIColor greenColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = YES;
    [self.view addSubview:mainScrollView];
    
    /** 第一页面 table*/
    OneTable = [[UITableView alloc] init];
    OneTable.frame = CGRectMake(0,0, kWidth, kHeight - 64);
    OneTable.separatorColor = [UIColor greenColor];
    OneTable.delegate = self;
    OneTable.dataSource = self;
    OneTable.rowHeight = 80;
    [mainScrollView addSubview:OneTable];
    
//    /** 第二页面 scrollView*/
//    UIScrollView *TwoScrollView = [[UIScrollView alloc] init];
//    TwoScrollView.frame = CGRectMake(0, kHeight + 64, kWidth, kHeight - 64);
//    TwoScrollView.contentSize = CGSizeMake(kWidth * 3, kHeight - 64);
//    TwoScrollView.backgroundColor = [UIColor cyanColor];
//    TwoScrollView.pagingEnabled = YES;
//    TwoScrollView.bounces = NO;
//    
//    [mainScrollView addSubview:TwoScrollView];
    
    /** 第二页面 table*/
    TwoTable = [[UITableView alloc] init];
//    TwoTable.frame = CGRectMake(0, 0, kWidth, kHeight - 64);
    TwoTable.frame = CGRectMake(0, kHeight + 64, kWidth, kHeight - 64);
    TwoTable.separatorColor = [UIColor redColor];
    TwoTable.delegate = self;
    TwoTable.dataSource = self;
    [mainScrollView addSubview:TwoTable];
//    [TwoScrollView addSubview:TwoTable];
    
    //设置UITableView 上拉加载
    OneTable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
        //设置动画效果
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            //            self.scrollV.contentOffset = CGPointMake(0, IPHONE_H);
            [mainScrollView setContentOffset:CGPointMake(0, kHeight)];
            
        } completion:^(BOOL finished) {
            //结束加载
            [OneTable.mj_footer endRefreshing];
        }];
    }];
    
    //设置TwoTable 有下拉操作
    TwoTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        //        self.scrollV.contentOffset = CGPointMake(0,0);
        
        [UIView animateWithDuration:1 animations:^{
            [mainScrollView setContentOffset:CGPointMake(0, - 64)];
            
        }];
        //结束加载
        [TwoTable.mj_header endRefreshing];
    }];
}

#pragma mark---------tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if([tableView isEqual:OneTable]) {
        height = 80;
        
    } else {
        return 120;
    }
    return height;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--askl",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"6"];
    return  cell;
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
