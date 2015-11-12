//
//  JWRowCell.h
//  Demo
//
//  Created by fengjiwen on 15/11/11.
//  Copyright © 2015年 fengjiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWRow;
@interface JWRowCell : UITableViewCell
/** 字典模型*/
@property (nonatomic ,strong)JWRow *rows;
/** 类工厂方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
