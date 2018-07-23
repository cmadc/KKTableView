//
//  KKTableView.m
//  BTravel
//
//  Created by CaiMing on 2017/7/11.
//  Copyright © 2017年 CaiMing. All rights reserved.
//

#import "KKTableView.h"
#import "KKTableViewModel.h"
#import "UITableView+DequeueReusableCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@protocol KKTableViewDataSource <UITableViewDataSource>

@end

@protocol KKTableViewDelegate <UITableViewDelegate>

@end

@interface KKTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)id<KKTableViewDataSource> kkDataSource;
@property(nonatomic,weak)id<KKTableViewDelegate> kkDelegate;

//@property(nonatomic,strong)KKNotResultView *resultView;
//Declaration of 'objc_property_t' must be imported from module 'ObjectiveC.runtime' before it is required

@end

@implementation KKTableView

//- (NSArray *)getAllPropertiesWithObject:(Class)class
//{
//    u_int count;
//    objc_property_t *properties  =class_copyPropertyList(class, &count);
//    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++)
//    {
//        const char* propertyName =property_getName(properties[i]);
//        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
//    }
//    free(properties);
//    return propertiesArray;
//}
//Cannot synthesize weak property because the current deployment target does not support weak references
+ (KKTableView*)tableViewWithStyle:(UITableViewStyle)style;
{
    KKTableView *view = [[KKTableView alloc]initWithFrame:CGRectZero style:style];
    view.separatorStyle = UITableViewCellSeparatorStyleNone;
    view.dataSource = view;
    view.delegate = view;
    view.estimatedSectionHeaderHeight = 0;
    view.estimatedSectionFooterHeight = 0;
    view.estimatedRowHeight = 0;
    return view;
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    
    for (NSIndexPath *indexPath in indexPaths) {
        
        KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
        
        if ([cell respondsToSelector:@selector(reloadData:)]) {
            [cell performSelector:@selector(reloadData:) withObject:cellModel.data];
        }
#pragma clang diagnostic pop
        
    }

}

- (void)setTableViewModel:(KKTableViewModel *)tableViewModel
{
    _tableViewModel = tableViewModel;
    for (KKSectionModel *section in _tableViewModel.sectionDataList)
    {
        for (KKCellModel *cellModel in section.cellDataList) {
            
            [self registerClass:cellModel.cellClass forCellReuseIdentifier:NSStringFromClass(cellModel.cellClass)];
        }
    }
    
    [self reloadData];
    if (self.tableViewModel.emptyView) {
        
        if (![_tableViewModel cellModelAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]])
        {
            [self addSubview:self.tableViewModel.emptyView];
            self.tableViewModel.emptyView.frame = self.bounds;
            self.tableViewModel.emptyView.hidden = NO;
        }else
        {
            self.tableViewModel.emptyView.hidden = YES;
        }
    }
    
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    
    if (!self.dataSource) {
        
        [super setDataSource:dataSource];
        
    }else
    {
        self.kkDataSource = (id<KKTableViewDataSource>)dataSource;
    }
    
}

-(void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (!self.delegate) {
        
        [super setDelegate:delegate];
        
    }else
    {
        self.kkDelegate = (id<KKTableViewDelegate>)delegate;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.kkDataSource && [self.kkDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
    {
        return [self.kkDataSource tableView:tableView numberOfRowsInSection:section];
    }
    KKSectionModel *sectionModel = self.tableViewModel.sectionDataList[section];
    return sectionModel.cellDataList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.kkDataSource && [self.kkDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.kkDataSource numberOfSectionsInTableView:tableView];
    }
    return self.tableViewModel.sectionDataList.count;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.kkDataSource && [self.kkDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.kkDataSource sectionIndexTitlesForTableView:tableView];
    }
    return self.tableViewModel.sectionTitleList;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDataSource && [self.kkDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.kkDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithClass:cellModel.cellClass];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([cell respondsToSelector:@selector(reloadData:)]) {
        
        [cell performSelector:@selector(reloadData:) withObject:cellModel.data];
    }

    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self.kkDelegate];
    }
#pragma clang diagnostic pop
    
    
    return cell;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if (self.kkDataSource && [self.kkDataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
    {
        [self.kkDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.kkDataSource &&[self.kkDataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        
        return [self.kkDataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
    
}


#pragma mark - UITableViewDelegate



// Display customization

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
//        return [self.kkDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
//    }
//    return 50;
//}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.kkDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.kkDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }

}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.kkDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0)
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.kkDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.kkDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.kkDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        
        return  [self.kkDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    if (cellModel.height>1) {
        return cellModel.height;
    }else
    {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(cellModel.cellClass) cacheByKey:indexPath configuration:^(id cell) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
            
            if ([cell respondsToSelector:@selector(reloadData:)]) {
                [cell performSelector:@selector(reloadData:) withObject:cellModel.data];
            }
#pragma clang diagnostic pop
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        
        return  [self.kkDelegate tableView:tableView heightForFooterInSection:section];
    }
    
    KKSectionModel *sectionModel = [self.tableViewModel.sectionDataList objectAtIndex:section];
    return sectionModel.footerData.height;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        
        return  [self.kkDelegate tableView:tableView heightForHeaderInSection:section];
    }
    KKSectionModel *sectionModel = [self.tableViewModel.sectionDataList objectAtIndex:section];
    
    
    return sectionModel.headerData.height;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        
        return  [self.kkDelegate tableView:tableView viewForFooterInSection:section];
    }
    
    
    KKSectionModel *sectionModel = self.tableViewModel.sectionDataList[section];
    
    UITableViewHeaderFooterView * views = [tableView dequeueReusableHeaderFooterViewWithClass:sectionModel.footerData.cellClass];
    views.tag = section;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"

    if ([views respondsToSelector:@selector(reloadData:)]) {
        [views performSelector:@selector(reloadData:) withObject:sectionModel.footerData.data];
    }
    if ([views respondsToSelector:@selector(setDelegate:)]) {
        [views performSelector:@selector(setDelegate:) withObject:self.kkDelegate];
    }
    
#pragma clang diagnostic pop

    
    return views;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        
        return  [self.kkDelegate tableView:tableView viewForHeaderInSection:section];
    }
    
    KKSectionModel *sectionModel = self.tableViewModel.sectionDataList[section];
    UITableViewHeaderFooterView * views = [tableView dequeueReusableHeaderFooterViewWithClass:sectionModel.headerData.cellClass];
    views.tag = section;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([views respondsToSelector:@selector(reloadData:)]) {
        [views performSelector:@selector(reloadData:) withObject:sectionModel.headerData.data];
    }
    
    if ([views respondsToSelector:@selector(setDelegate:)]) {
        [views performSelector:@selector(setDelegate:) withObject:self.kkDelegate];
    }
#pragma clang diagnostic pop
    
    return views;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.kkDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [self.kkDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        
    }else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
        if (cellModel.routerModel) {
//            [(NSObject*)self.kkDelegate invokeMethodWithMethodName:cellModel.routerModel.methodName param:cellModel.routerModel.param];
            [[CMRouter sharedInstance]showViewControllerWithRouterModel:cellModel.routerModel];
        }

    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        
        return [self.kkDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.kkDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}




- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
       return  [self.kkDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    return @[];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        
        [self.kkDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {

    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        
        [self.kkDelegate scrollViewDidZoom:scrollView];
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        
        [self.kkDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        
        [self.kkDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        
        [self.kkDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        
        [self.kkDelegate scrollViewWillBeginDecelerating:scrollView];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.kkDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.kkDelegate && [self.kkDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.kkDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

@end





