//
//  WebScrollView.m
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import "WebScrollView.h"

@implementation WebScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews
- (void)setupViews {
    UIView *bgHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50)];
    bgHeaderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgHeaderView];
    
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
    
    [self addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 50, kWidth, kHeight-50-64);
}

#pragma mark - lazyLoading
-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    return _webView;
}



@end
