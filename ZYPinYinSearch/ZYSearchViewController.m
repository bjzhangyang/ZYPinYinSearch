//
//  ZYSearchViewController.m
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYSearchViewController.h"
#import "Person.h"
#import "ZYPinYinSearch.h"
@interface ZYSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) NSMutableArray  * originalArray;
@property (nonatomic,strong) NSArray         * dataSourceArray;
@property (nonatomic,strong) UITableView     * tableView;
@property (nonatomic,strong) UIBarButtonItem * searchButton;
@property (nonatomic,strong) UISearchBar     * searchBar;
@property (nonatomic,strong) UIBarButtonItem * backButton;
@end

@implementation ZYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];//根据上个页面传过来的type值，初始化模拟数据
    [self createUI];
}
#pragma -mark 自定义方法
-(void)initData{
    _originalArray = [NSMutableArray array];
    NSArray * personNames = @[@"长春",@"重庆",@"李四",@"王五",@"赵六",@"孙七"];
    NSArray * nicknames = @[@"帅哥",@"王大妞",@"李傻子",@"王瘸子",@"赵瞎子",@"孙子"];
    if([self.type isEqualToString:@"字符串"]){
        for (int i = 0; i < personNames.count; i++) {
            [_originalArray addObject:personNames[i]];//原始数据，数组中保存字符串
        }
    }
    else if([self.type isEqualToString:@"字典"]){
        for (int i = 0; i < personNames.count; i++) {
            NSDictionary * dic = [NSDictionary dictionaryWithObjects:@[personNames[i],[NSString stringWithFormat:@"%d",i+24]] forKeys:@[@"name",@"age"]];
            [_originalArray addObject:dic];//原始数据，数组中保存字典
        }
    }
    else if([self.type isEqualToString:@"Model"]){
        for (int i = 0; i < personNames.count; i++) {
            Person * person = [Person CreatePersonWithName:personNames[i] andNickname:nicknames[i]];
            [_originalArray addObject:person];//原始数据，数组中保存Model对象
        }
    }
    
    _dataSourceArray = [NSArray arrayWithArray:_originalArray];
}
-(void)createUI{
    self.title = self.type;
    self.view.backgroundColor = [UIColor colorWithRed:26/255.0 green:61/255.0 blue:89/255.0 alpha:1];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    UIView * tempView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tempView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 28, 22);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"searchButton"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(jumpToSearch) forControlEvents:UIControlEventTouchUpInside];
    _searchButton= [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = _searchButton;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 28, 22);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    _backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = _backButton;


}
- (void)jumpToSearch
{
    self.navigationItem.rightBarButtonItem=nil;
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.center = CGPointMake(kWidth/2, 84);
    _searchBar.frame = CGRectMake(10, 20,kWidth-20, 0);
    [_searchBar setContentMode:UIViewContentModeBottomLeft];
    _searchBar.delegate = self;
    _searchBar.backgroundColor=[UIColor clearColor];
    _searchBar.searchBarStyle=UISearchBarStyleDefault;
    _searchBar.showsCancelButton =YES;
    _searchBar.tag=1000;
    [self.navigationController.navigationBar addSubview:_searchBar];
    _searchBar.placeholder = @"关键字搜索";
    //-------------------------------------------------------------------
    [_searchBar becomeFirstResponder];
}
- (void)backward
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma -mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    if([self.type isEqualToString:@"字符串"]){
        cell.textLabel.text = _dataSourceArray[indexPath.row];
    }
    else if([self.type isEqualToString:@"字典"]){
        NSDictionary * dict = _dataSourceArray[indexPath.row];
        cell.textLabel.text = dict[@"name"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄:%@",dict[@"age"]];
    }
    else if([self.type isEqualToString:@"Model"]){
        Person * person = _dataSourceArray[indexPath.row];
        cell.textLabel.text = person.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"外号:%@",person.nickname];
    }
    return cell;
}

#pragma -mark searchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.navigationItem.rightBarButtonItem = _searchButton;
    [_searchBar resignFirstResponder];
    [_searchBar removeFromSuperview];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@""]) {
        _dataSourceArray = _originalArray;
        
    }
    else{
#warning 主要功能，调用方法实现搜索
        [ZYPinYinSearch searchByPropertyName:@"name" withOriginalArray:_originalArray searchText:searchBar.text success:^(NSArray *results) {
            _dataSourceArray = results;
            [_tableView reloadData];
        } failure:^(NSString *errorMessage) {
            
        }];
    }
    
    self.navigationItem.rightBarButtonItem = _searchButton;
    [_searchBar resignFirstResponder];
    [_searchBar removeFromSuperview];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        _dataSourceArray = _originalArray;
        [_tableView reloadData];
    }
    else{
#warning 主要功能，调用方法实现搜索
        [ZYPinYinSearch searchByPropertyName:@"name" withOriginalArray:_originalArray searchText:searchBar.text success:^(NSArray *results) {
            _dataSourceArray = results;
            [_tableView reloadData];
        } failure:^(NSString *errorMessage) {
            
        }];
    }
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //取消按钮 重置
    UITextField *tf;
    for (UIView *view in [[_searchBar.subviews objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            tf=(UITextField *)view;
        }
    }
    [_searchBar setShowsCancelButton:YES animated:YES];
    _searchBar.showsCancelButton=YES;
    for(UIView *subView in searchBar.subviews){
        if([subView isKindOfClass:UIButton.class]){
            [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
            UIButton *button=(UIButton*)subView;
            button.titleLabel.textColor=[UIColor whiteColor];
        }
    }
    //取消字体变白
    UIButton *cancelButton;
    UIView *topView = _searchBar.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    if (cancelButton) {
        NSLog(@"%@",NSStringFromCGRect(cancelButton.frame));
        //Set the new title of the cancel button
        [cancelButton setTitle:@"       " forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.textColor=[UIColor whiteColor];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:20];
        [cancelButton removeFromSuperview];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(-5, -5,40,40)];
        lable.textAlignment=NSTextAlignmentLeft;
        lable.text=@"取消";
        lable.textColor=[UIColor whiteColor];
        [cancelButton addSubview:lable];
        lable.font = [UIFont fontWithName:@"Heiti SC" size:16];
        [cancelButton addSubview:lable];
        
    }
    UIButton * button;
    [button setTintColor:  nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
