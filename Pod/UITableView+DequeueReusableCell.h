//
//  UITableView+DequeueReusableCell.h
//  kakatrip
//
//  Created by CaiMing on 2017/4/13.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DequeueReusableCell)

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass;
- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)headerFooterClass;

@end
