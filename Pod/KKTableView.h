//
//  KKTableView.h
//  BTravel
//
//  Created by CaiMing on 2017/7/11.
//  Copyright © 2017年 CaiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKTableViewModel;
@interface KKTableView : UITableView

@property(nonatomic,strong)KKTableViewModel *tableViewModel;

+ (KKTableView*)tableViewWithStyle:(UITableViewStyle)style;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
