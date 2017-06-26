//
//  ViewController.m
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ViewController.h"
#import "ZYSearchViewController.h"
#import "ZYPinYinSearch.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * tempView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tempView];
    self.view.backgroundColor = [UIColor colorWithRed:26/255.0 green:61/255.0 blue:89/255.0 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    //处理多音字，指定词组的拼音，指定一次，整个APP运行过程中都有效，可以手动清除
    [ZYPinYinSearch setupReplacement:^NSDictionary *{
        return @{@"长春":@"changchun",@"重庆":@"chongqing"};
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonClicked:(UIButton *)sender {
    NSString * type;
    switch (sender.tag) {
        case 1:
            type = @"字符串";
            break;
        case 2:
            type = @"字典";
            break;
        case 3:
            type = @"Model";
            break;
        default:
            break;
    }
    [self performSegueWithIdentifier:@"push" sender:type];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ZYSearchViewController * target = [segue destinationViewController];
    target.type = sender;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
