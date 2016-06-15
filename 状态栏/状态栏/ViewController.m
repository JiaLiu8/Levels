//
//  ViewController.m
//  状态栏
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 liujia. All rights reserved.
//

#import "ViewController.h"
#import "StatusBarMessage.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tB;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAction)];
    _tB=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tB.delegate=self;
    _tB.dataSource=self;
    [_tB registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tB];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=@"hello";
    return cell;
}
-(void)clickAction
{
    [StatusBarMessage show:@"下载成功"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
