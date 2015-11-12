//
//  JWTableViewController.m
//  Demo
//
//  Created by fengjiwen on 15/11/11.
//  Copyright © 2015年 fengjiwen. All rights reserved.
//

#import "JWTableViewController.h"
#import "JWRow.h"
#import "JWRowCell.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>
@interface JWTableViewController ()
/** 存储模型的数组*/
@property (nonatomic, strong) NSMutableArray *Rows;
/** 解析JSON数据的字典*/
@property (nonatomic ,strong)NSDictionary *dict;
@end

@implementation JWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpItem];
    //获取网路数据
    [self getdata];
    //自动设置cell的行高
    self.tableView.estimatedRowHeight = 30;

}
#pragma mark - Item的设置
- (void)setUpItem
{
    self.title = @"伟基网络";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor darkGrayColor];
}
#pragma mark - 刷新按钮的点击
- (void)rightClick
{
    self.tableView = [[UITableView alloc] initWithFrame:JWScreen style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //添加一个蒙板
    [SVProgressHUD showWithStatus:@"正在刷新"];
    //延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
    });
    
        [self getdata];
    self.tableView.estimatedRowHeight = 30;
    

}
#pragma mark - 获取网络数据
- (void)getdata
{
    [JWRow mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Description":@"description"};
    }];
    
    NSString *str =[NSString  stringWithFormat: @"http://thoughtworks-ios.herokuapp.com/facts.json"];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 1.创建NSURLSession
    NSURLSession *session = [NSURLSession sharedSession];
    // 2.利用NSURLSession创建Task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        /*
         data: 服务器返回给我们的数据
         response : 响应头
         error: 错误信息
         */
        
        [data writeToFile:@"/Users/fengjiwen/Desktop/567.plist" atomically:YES];
        self.dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
         self.Rows = [JWRow mj_objectArrayWithKeyValuesArray:self.dict[@"rows"]];
        
       dispatch_async(dispatch_get_main_queue(), ^{
           //刷新表格
           [self.tableView reloadData];
       });
        
    }];
    // 3.执行Task
    [task resume];
    


}
#pragma mark - TableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.Rows.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWRowCell *cell = [JWRowCell cellWithTableView:tableView];
    cell.rows = self.Rows[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return self.dict[@"title"];

}

@end
