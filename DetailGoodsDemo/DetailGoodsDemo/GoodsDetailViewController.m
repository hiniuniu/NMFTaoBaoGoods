//
//  GoodsDetailViewController.m
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}


#pragma mark - setupViews
- (void)setupViews {
    [self.view addSubview:self.scrollView];
    
    UIView *bgHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50)];
    bgHeaderView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:bgHeaderView];
    
    UIButton *productionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [productionBtn setTitle:@"商品介绍" forState:UIControlStateNormal];
    [productionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    productionBtn.frame = CGRectMake(0, 0, 100, 40);
    [bgHeaderView addSubview:productionBtn];
    
    UIButton *paramBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paramBtn setTitle:@"规格参数" forState:UIControlStateNormal];
    [paramBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    paramBtn.frame = CGRectMake(100, 0, 100, 40);
    [bgHeaderView addSubview:paramBtn];
    
    UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [listBtn setTitle:@"包装清单" forState:UIControlStateNormal];
    [listBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    listBtn.frame = CGRectMake(200, 0, 100, 40);
    [bgHeaderView addSubview:listBtn];
    
    [self.scrollView addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 50, kWidth, kHeight-50-64);
}

#pragma mark - lazyLoading
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
        _scrollView.backgroundColor = [UIColor purpleColor];
    }
    return _scrollView;
}

-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    return _webView;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
