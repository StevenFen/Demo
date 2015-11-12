//
//  JWRow.h
//  Demo
//
//  Created by fengjiwen on 15/11/11.
//  Copyright © 2015年 fengjiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JWRow : NSObject
/** 内容*/
@property (nonatomic,copy)NSString *Description;
/** 标题*/
@property (nonatomic,copy)NSString *title;
/** 图片*/
@property (nonatomic ,copy)NSString *imageHref;
@end
