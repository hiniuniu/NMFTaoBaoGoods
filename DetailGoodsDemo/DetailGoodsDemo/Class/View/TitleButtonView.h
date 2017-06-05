//
//  TitleButtonView.h
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^titleLabelBlock)(NSInteger index);

@interface TitleButtonView : UIView

@property (nonatomic, copy) titleLabelBlock titleLabelBlock;

//scrollView
@property (nonatomic, strong) UIScrollView      *scrollView;

//滑动视图触发
- (void)clickTitleButtonWithIndex:(NSInteger)index;

@end
