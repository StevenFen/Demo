//
//  JWRowCell.m
//  Demo
//
//  Created by fengjiwen on 15/11/11.
//  Copyright © 2015年 fengjiwen. All rights reserved.
//

#import "JWRowCell.h"
#import "JWRow.h"
#import <UIImageView+WebCache.h>
@interface JWRowCell ()
/** 内容*/
@property (weak, nonatomic) IBOutlet UILabel *Description;
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *title;
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageHref;
@end
@implementation JWRowCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    JWRowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JWRowCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
#pragma mark-给控件赋值
- (void)setRows:(JWRow *)rows
{
    _rows = rows;

    self.Description.text = rows.Description;
   
    self.title.text = rows.title;
    
    [self.imageHref sd_setImageWithURL:[NSURL URLWithString:rows.imageHref] placeholderImage:nil];
    
    
}


@end
