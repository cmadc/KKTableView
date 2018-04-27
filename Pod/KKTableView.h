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


//@class KKCellModel;
//@class KKSectionModel;
//
//@interface KKTableViewModel : NSObject
//
//@property(nonatomic,readonly,strong)NSMutableArray<KKSectionModel *> *sectionDataList;
//@property(nonatomic,strong)NSMutableArray<NSString *> *sectionTitleList;
//
//@property(nonatomic,weak)id<NSObject> customDelegate;
//@property(nonatomic,copy)NSString *noResultImageName;
//@property(nonatomic,copy)NSString *noResultTitle;
//@property(nonatomic,copy)NSString *noResultDesc;
//@property(nonatomic)id headerViewModel;
//
//- (KKCellModel*)cellModelAtIndexPath:(NSIndexPath*)indexPath;
//
//- (void)addSetionModel:(KKSectionModel*)model;
//- (void)insertSetionModel:(KKSectionModel *)model atIndex:(NSInteger)index;
//- (void)addSetionModelList:(NSArray<KKSectionModel*>*)modellist;
//
//
//- (void)removeSetionModel:(KKSectionModel*)model;
//- (void)removeSetionModelAtIndex:(NSInteger)index;
//- (void)removeSetionModelList:(NSArray<KKSectionModel*>*)modellist;
//- (void)removeAllObjects;
//
//- (void)removeCellModelWithIndexPaths:(NSArray<NSIndexPath*>*)indexPaths;
//
//
//- (KKSectionModel *)findSectionWithSectionType:(NSString*)section;
//- (NSArray<KKCellModel*>*)findCellModelWithCellType:(NSString*)cellType;
//- (NSArray<NSIndexPath*>*)findCellModelIndexPathsWithCellType:(NSString*)cellType;
//
//@end
//
//@interface KKSectionModel : NSObject
//
//@property(nonatomic,strong)NSString  *sectionType;
//@property(nonatomic,strong)KKCellModel *headerData;
//@property(nonatomic,strong)KKCellModel *footerData;
//@property(nonatomic,readonly,strong)NSMutableArray<KKCellModel*> *cellDataList;
//
//@property(nonatomic,assign)NSInteger displayCellCount;
//
//- (void)addCellModel:(KKCellModel*)model;
//- (void)insertCellModel:(KKCellModel*)model atIndex:(NSInteger)index;
//- (void)addCellModelList:(NSArray<KKCellModel*>*)modellist;
//
//- (void)removeCellModel:(KKCellModel*)model;
//- (void)removeCellModelAtIndex:(NSInteger)index;
//- (void)removeCellModelList:(NSArray<KKCellModel*>*)modellist;
//- (void)removeAllObjects;
//
//@end
//
//
//@interface KKCellModel : NSObject
//
//@property(nonatomic)Class cellClass;
//@property(nonatomic)id data;
//@property(nonatomic)CGFloat height;
//@property(nonatomic,strong)NSString *cellType;
//@property(nonatomic,strong)RouterModel *routerModel;
//
//@end
