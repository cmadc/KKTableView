//
//  UITableView+DequeueReusableCell.m
//  kakatrip
//
//  Created by CaiMing on 2017/4/13.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "UITableView+DequeueReusableCell.h"


@implementation UITableView (DequeueReusableCell)

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass;
{
    NSString *tips = nil;
    if (![cellClass isSubclassOfClass:[UITableViewCell class]])
    {
        cellClass = [UITableViewCell class];
        tips = @"当前版本赞不支持,请升级App";
    }
    UITableViewCell *cell=[self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    if (cell==nil) {
        cell=[[cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(cellClass)];
        cell.textLabel.text = tips;
    }
    return cell;
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)headerFooterClass;
{
    if (![headerFooterClass isSubclassOfClass:[UITableViewHeaderFooterView class]])
    {
        headerFooterClass = [UITableViewHeaderFooterView class];
    }
    
    UITableViewHeaderFooterView *cell=[self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerFooterClass)];
    if (cell==nil) {
        cell=[[headerFooterClass alloc]initWithReuseIdentifier:NSStringFromClass(headerFooterClass)];
    }
    return cell;
}


@end
