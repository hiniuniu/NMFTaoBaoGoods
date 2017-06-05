//
//  TwoViewController.m
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import "TwoViewController.h"
#import "AddShoppingCartViewController.h"
#import "WebScrollView.h"
#import "TitleButtonView.h"

@interface TwoViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) TitleButtonView   *buttonView;
@property (nonatomic, strong) UIScrollView      *mainScrollView;
@property (nonatomic, strong) UIScrollView      *goodsScrollView;     //上面的滑动视图

//@property (nonatomic, strong) UITableView       *goodsTableView;      //商品的tableView
//@property (nonatomic, strong) UIWebView         *webView;             //商品详情的
@property (nonatomic, strong) AddShoppingCartViewController *addShVC;


@property (nonatomic, assign) BOOL              canScroll_TitleButton;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canScroll_TitleButton = YES;
    
    [self resetNav];
    [self setupViews];
    [self setupAction];
}

#pragma mark - resetNav
- (void)resetNav {
    self.navigationItem.titleView = self.buttonView;
}

- (void)setupViews {
    /** 底层 scrollView*/
    self.mainScrollView.frame = CGRectMake(0, 0, kWidth, kHeight);
    [self.view addSubview:self.mainScrollView];
    
    /** 第一页面 scrollView*/
    self.goodsScrollView.frame = CGRectMake(0, 0, kWidth, kHeight - 64);
    [self.mainScrollView addSubview:self.goodsScrollView];
    
    /** 第一页面 1 table*/
    _addShVC = [[AddShoppingCartViewController alloc] init];
    _addShVC.tableView.frame = CGRectMake(0, 0, kWidth, kHeight - 64);
    [self addChildViewController:_addShVC];
    [self.goodsScrollView addSubview:_addShVC.tableView];
    
    /** 第一页面 2 scrollView*/
    WebScrollView *secondPageScrollView1 = [[WebScrollView alloc] init];
    secondPageScrollView1.frame = CGRectMake(kWidth, 0, kWidth, kHeight - 64);
    secondPageScrollView1.backgroundColor = [UIColor greenColor];
    [self.goodsScrollView addSubview:secondPageScrollView1];
    
    /** 第二页面*/
    WebScrollView *secondPageScrollView = [[WebScrollView alloc] init];
    secondPageScrollView.frame = CGRectMake(0, kHeight + 64, kWidth, kHeight - 64);
    secondPageScrollView.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:secondPageScrollView];

    //设置UITableView 上拉加载
    _addShVC.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
        //设置动画效果
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.mainScrollView setContentOffset:CGPointMake(0, kHeight)];
            
        } completion:^(BOOL finished) {
            //结束加载
            [_addShVC.tableView.mj_footer endRefreshing];
        }];
    }];
    
    //设置TwoTable 有下拉操作
    secondPageScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        [UIView animateWithDuration:1 animations:^{
            [self.mainScrollView setContentOffset:CGPointMake(0, - 64)];
        }];
        //结束加载
        [secondPageScrollView.mj_header endRefreshing];
    }];
}

#pragma mark - setupAction
- (void)setupAction {
    MPWeakSelf(self);
    
    //导航栏 按钮s
    self.buttonView.titleLabelBlock = ^(NSInteger index) {
        NSLog(@"%ld", index);
        MPStrongSelf(self);
        if (self.canScroll_TitleButton) {
            
            NSLog(@"滑动");
            [UIView animateWithDuration:0.2 animations:^{
                MPStrongSelf(self);
                
                if (index) {
                    self.goodsScrollView.contentOffset = CGPointMake(kWidth, 0);
                } else {
                    self.goodsScrollView.contentOffset = CGPointMake(0, 0);
                }
                
            }];
            
        } else {
            NSLog(@"不能滑动");
        }
    };


}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.mainScrollView) {
        CGFloat contentY = scrollView.contentOffset.y;
        NSLog(@"%lf", contentY);
        
        if (contentY >= kHeight) {
            self.canScroll_TitleButton = NO;
            
            [UIView animateWithDuration:0.8 animations:^{
                [self.buttonView.scrollView setContentOffset:CGPointMake(0, 44) animated:YES];
            }];
            
        } else {
            self.canScroll_TitleButton = YES;
            [UIView animateWithDuration:0.3 animations:^{
                [self.buttonView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }];
        }
    } else if (scrollView == self.goodsScrollView) {
        CGFloat contentX = scrollView.contentOffset.x;
        NSLog(@"%lf", contentX);
        
        if (contentX >= kWidth) {
            
            [self.buttonView clickTitleButtonWithIndex:1];
        } else if(contentX <= 0) {
            
            [self.buttonView clickTitleButtonWithIndex:0];
        }
    }
    
}


#pragma mark - lazyLoading
-(TitleButtonView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[TitleButtonView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        
    }
    return _buttonView;
}

//页面底层 整体的scrollView
-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.contentSize = CGSizeMake(kWidth, kHeight * 2);
        _mainScrollView.backgroundColor = [UIColor greenColor];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = YES;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

-(UIScrollView *)goodsScrollView {
    if (!_goodsScrollView) {
        _goodsScrollView = [[UIScrollView alloc] init];
        _goodsScrollView.contentSize = CGSizeMake(kWidth * 2, kHeight - 64);
        _goodsScrollView.backgroundColor = [UIColor cyanColor];
        _goodsScrollView.pagingEnabled = YES;
        _goodsScrollView.bounces = NO;
        _goodsScrollView.delegate = self;
    }
    return _goodsScrollView;
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
