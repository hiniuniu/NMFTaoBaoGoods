//
//  TitleButtonView.m
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import "TitleButtonView.h"

#define ControlH 44
#define ControlW 50 

@interface TitleButtonView ()

@property (nonatomic, strong) UIButton          *goodsButton;
@property (nonatomic, strong) UIButton          *detailButton;
@property (nonatomic, strong) UIView            *lineView;
@property (nonatomic, strong) UILabel           *titleLabel;

@end

@implementation TitleButtonView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews
- (void)setupViews {
    [self addSubview:self.scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ControlH)];
    [self.scrollView addSubview:topView];
    
    [topView addSubview:self.goodsButton];
    [topView addSubview:self.detailButton];
    [topView addSubview:self.lineView];
    
    [self.scrollView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(0, ControlH, self.frame.size.width, ControlH);
}
#pragma mark - lazyLoading
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*2);
    }
    return _scrollView;
}

-(UIButton *)goodsButton {
    if (!_goodsButton) {
        _goodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_goodsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_goodsButton setTitle:@"商品" forState:UIControlStateNormal];
        [_goodsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _goodsButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _goodsButton;
}

-(UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_detailButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_detailButton setTitle:@"详情" forState:UIControlStateNormal];
        [_detailButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailButton;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"商品详情";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - frame
-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.goodsButton.frame = CGRectMake(0, 0, ControlW, ControlH);
    self.detailButton.frame = CGRectMake(ControlW, 0, ControlW, ControlH);
    self.lineView.frame = CGRectMake(0, ControlH-2, ControlW, 2);
}

#pragma mark - action
- (void)buttonAction:(UIButton *)sender {
    if (sender == self.goodsButton) {
        [self goodsButtonSelected];
        if (self.titleLabelBlock) {
            self.titleLabelBlock(0);
        }
        
    } else {
        [self detailButtonSelected];
        if (self.titleLabelBlock) {
            self.titleLabelBlock(1);
        }
    }
}


- (void)clickTitleButtonWithIndex:(NSInteger)index {
    
    if (index == 1) {
        [self detailButtonSelected];
    } else {
        [self goodsButtonSelected];
    }
}

//选中商品按钮
- (void)goodsButtonSelected {
    MPWeakSelf(self);
    [self.goodsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.detailButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        MPStrongSelf(self);
        self.lineView.frame = CGRectMake(0, ControlH-2, ControlW, 2);
    }];
}

//选中详情按钮
- (void)detailButtonSelected {
    MPWeakSelf(self);
    [self.detailButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.goodsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        MPStrongSelf(self);
        self.lineView.frame = CGRectMake(50, ControlH-2, ControlW, 2);
    }];
}


@end
