//
//  ViewController.m
//  DetailGoodsDemo
//
//  Created by Meng Fan on 2017/6/5.
//  Copyright © 2017年 Haowan. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "TwoViewController.h"
#import "AddShoppingCartViewController.h"
#import "GoodsDetailViewController.h"
#import "TitleButtonView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TitleButtonView *buttonView = [[TitleButtonView alloc] initWithFrame:CGRectMake(10, 300, 100, 44)];
    buttonView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buttonView];
}

- (IBAction)action:(id)sender {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (IBAction)twoAction:(id)sender {
    TwoViewController *detailVC = [[TwoViewController alloc] init];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)pushToGoods:(id)sender {
    AddShoppingCartViewController *detailVC = [[AddShoppingCartViewController alloc] init];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)pushToGoodsDetail:(id)sender {
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
