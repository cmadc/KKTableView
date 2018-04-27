//
//  KKTableViewModel.m
//  KKTableView
//
//  Created by CaiMing on 2018/4/27.
//  Copyright © 2018年 CaiMing. All rights reserved.
//

#import "KKTableViewModel.h"

@interface KKTableViewModel ()

@property(nonatomic,strong)NSMutableArray<KKSectionModel*> *sectionDataList;

@end

@implementation KKTableViewModel

- (KKCellModel*)cellModelAtIndexPath:(NSIndexPath*)indexPath
{
    KKSectionModel *sectionModel = [self.sectionDataList objectAtIndex:indexPath.section];
    if (sectionModel) {
        KKCellModel *cellModel = [sectionModel.cellDataList objectAtIndex:indexPath.row];
        return cellModel;
    }
    return nil;
}


- (void)addSetionModel:(KKSectionModel*)model
{
    [self.sectionDataList addObject:model];
}
- (void)insertSetionModel:(KKSectionModel *)model atIndex:(NSInteger)index
{
    [self.sectionDataList insertObject:model atIndex:index];
}
- (void)addSetionModelList:(NSArray<KKSectionModel*>*)modellist
{
    [self.sectionDataList addObjectsFromArray:modellist];
}

- (void)removeSetionModel:(KKSectionModel*)model
{
    [self.sectionDataList removeObject:model];
}
- (void)removeSetionModelAtIndex:(NSInteger)index
{
    [self.sectionDataList removeObjectAtIndex:index];
}

- (void)removeSetionModelList:(NSArray<KKSectionModel*>*)modellist
{
    [self.sectionDataList removeObjectsInArray:modellist];
}

- (NSMutableArray<KKSectionModel*> *)sectionDataList
{
    if (!_sectionDataList) {
        
        _sectionDataList = @[].mutableCopy;
        
    }
    return _sectionDataList;
}

- (void)removeAllObjects
{
    [self.sectionDataList removeAllObjects];
}

- (void)removeCellModelWithIndexPaths:(NSArray<NSIndexPath*>*)indexPaths
{
    for (NSIndexPath *indexPath in indexPaths) {
        
        KKSectionModel *sectionModel = [self.sectionDataList objectAtIndex:indexPath.section];
        [sectionModel removeCellModelAtIndex:indexPath.row];
    }
}

- (KKSectionModel *)findSectionWithSectionType:(NSString*)sectionType
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"sectionType == %@",sectionType];
    NSArray *result = [self.sectionDataList.copy filteredArrayUsingPredicate:pred];
    if (result.count>0) {
        
        return result.firstObject;
    }
    return nil;
}

- (NSArray<KKCellModel*>*)findCellModelWithCellType:(NSString*)cellType
{
    NSMutableArray *mArr = @[].mutableCopy;
    for (KKSectionModel *sectionModel in self.sectionDataList)
    {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"cellType == %@",cellType];
        NSArray *result = [sectionModel.cellDataList.copy filteredArrayUsingPredicate:pred];
        if (result.count>0) {
            [mArr addObjectsFromArray:result];
        }
    }
    return mArr.copy;
}
- (NSArray<NSIndexPath*>*)findCellModelIndexPathsWithCellType:(NSString*)cellType
{
    NSMutableArray *mArr = @[].mutableCopy;
    NSInteger section = 0;
    for (KKSectionModel *sectionModel in self.sectionDataList)
    {
        NSInteger row = 0;
        for (KKCellModel*cellModel in sectionModel.cellDataList)
        {
            if ([cellModel.cellType isEqualToString:cellType])
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                
                [mArr addObject:indexPath];
            }
            row++;
            
        }
        section ++;
    }
    return mArr.copy;
}

@end


@interface KKSectionModel ()

@property(nonatomic,strong)NSMutableArray<KKCellModel *> *cellDataList;

@end

@implementation KKSectionModel

- (void)addCellModel:(KKCellModel*)model
{
    [self.cellDataList addObject:model];
}
- (void)insertCellModel:(KKCellModel *)model atIndex:(NSInteger)index
{
    [self.cellDataList insertObject:model atIndex:index];
}
- (void)addCellModelList:(NSArray<KKCellModel*>*)modellist
{
    [self.cellDataList addObjectsFromArray:modellist];
}

- (void)removeCellModel:(KKCellModel*)model
{
    [self.cellDataList removeObject:model];
}
- (void)removeCellModelAtIndex:(NSInteger)index
{
    [self.cellDataList removeObjectAtIndex:index];
}

- (void)removeCellModelList:(NSArray<KKCellModel*>*)modellist
{
    [self.cellDataList removeObjectsInArray:modellist];
}

- (NSMutableArray<KKCellModel *> *)cellDataList
{
    if (!_cellDataList) {
        
        _cellDataList = @[].mutableCopy;
        
    }
    return _cellDataList;
}

- (void)removeAllObjects
{
    [self.cellDataList removeAllObjects];
}

- (instancetype)init
{
    self = [super init];
    self.footerData = [KKCellModel new];
    self.headerData = [KKCellModel new];
    return self;
}

@end

@interface KKCellModel ()

@end

@implementation KKCellModel

- (instancetype)init
{
    self = [super init];
    self.height = 0.01f;
    return self;
}
- (CMRouterModel *)routerModel
{
    if (!_routerModel) {
        _routerModel = [CMRouterModel new];
    }
    return _routerModel;
}

@end

