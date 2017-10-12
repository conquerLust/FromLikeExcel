//
//  BaoBiaoLayout.m
//  collectionview
//
//  Created by admin on 2017/2/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaoBiaoLayout.h"
#import "ItemModel.h"

#define MinmumItemWidth  68.0
#define MinmumItemHeight  44.0

@interface BaoBiaoLayout()
{
    NSUInteger _allColumns;//总列数
    NSInteger _lockColumn;//锁定列数
    NSMutableArray *_itemsArray;
}

@property(nonatomic,strong)NSMutableArray *itemAttributes;//所有item的布局
@property(nonatomic,strong)NSMutableArray *itemsSize;//一行里面所有item的宽，每一行都是一样的
@property(nonatomic,assign)CGSize contentSize;//collectionView的contentSize大小

@end

@implementation BaoBiaoLayout

-(id)init{
    self=[super init];
    _lockColumn = 0;
    _allColumns = 0;
    return self;
}

//设置 锁定列数
-(void)setLockColumn:(NSInteger)lockColumn{
    _lockColumn = lockColumn;
}


-(void)setItems:(NSArray *)itemsArr{
    _itemsArray=[NSMutableArray arrayWithArray:itemsArr];
    _allColumns=((NSArray *)_itemsArray[0]).count;
}

//重置每一个item的大小和布局
-(void)reset{
    if (self.itemAttributes) {
        [self.itemAttributes removeAllObjects];
    }
    if (self.itemsSize) {
        [self.itemsSize removeAllObjects];
    }
}

#pragma mark - 设置 行 里面的 item 的Size（每一列的宽度一样，所以只需要确定一行的item的宽度）
- (void)calculateItemsSize
{
    
    [_itemsArray enumerateObjectsUsingBlock:^(NSArray *  _Nonnull arr, NSUInteger section, BOOL * _Nonnull stop) {
        NSMutableArray *sectionsSize=[NSMutableArray arrayWithCapacity:0];
        [arr enumerateObjectsUsingBlock:^(ItemModel *  _Nonnull obj, NSUInteger column, BOOL * _Nonnull stop) {
            CGSize itemSize = CGSizeMake(MinmumItemWidth*obj.crossColumns, MinmumItemHeight*obj.crossRows);
            NSValue *itemSizeValue = [NSValue valueWithCGSize:itemSize];
            [sectionsSize addObject:itemSizeValue];
        }];
        [self.itemsSize addObject:sectionsSize];
    }];
}

//每一个滚动都会走这里，去确定每一个item的位置
-(void)prepareLayout{
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    
    NSUInteger column = 0;//列
    CGFloat xOffset = 0.0;//X方向的偏移量
    CGFloat yOffset = 0.0;//Y方向的偏移量
    CGFloat contentWidth = 0.0;//collectionView.contentSize的宽度
    CGFloat contentHeight = 0.0;//collectionView.contentSize的高度
    
    if (self.itemAttributes.count > 0) {
        for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger row = 0; row < numberOfItems; row++) {
                if (section != 0 && row >= _lockColumn) {
                    continue;
                }
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:row inSection:section]];
                if (section == 0) {
                    CGRect frame = attributes.frame;
                    frame.origin.y = self.collectionView.contentOffset.y;
                    attributes.frame = frame;
                }
                //确定锁定列的位置
                if (row < _lockColumn) {
                    CGRect frame = attributes.frame;
                    float offsetX = 0;
                    if (index > 0) {
                        for (int i = 0; i < row; i++) {
                            offsetX += MinmumItemWidth;
                        }
                    }
                    
                    frame.origin.x = self.collectionView.contentOffset.x + offsetX;
                    attributes.frame = frame;
                }
            }
        }
        
        return;
    }
    
    self.itemAttributes = [@[] mutableCopy];
    self.itemsSize = [@[] mutableCopy];
    
    if (self.itemsSize.count != _allColumns*[self.collectionView numberOfSections]) {
        [self calculateItemsSize];
    }
    
    for (int section = 0; section < [self.collectionView numberOfSections]; section ++) {
        NSMutableArray *sectionAttributes = [@[] mutableCopy];
        for (NSUInteger row = 0; row < _allColumns; row++) {
            CGSize itemSize = [self.itemsSize[section][row] CGSizeValue];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            if (section == 0 && row < _lockColumn) {
                attributes.zIndex = 2015;
            } else if (section == 0 || row < _lockColumn) {
                attributes.zIndex = 2014;
            }
            if (section == 0) {
                CGRect frame = attributes.frame;
                frame.origin.y = self.collectionView.contentOffset.y;
                attributes.frame = frame;
            }
            
            if (row < _lockColumn) {
                CGRect frame = attributes.frame;
                float offsetX = 0;
                if (index > 0) {
                    for (int i = 0; i < row; i++) {
                        offsetX += MinmumItemWidth;
                    }
                }
                
                frame.origin.x = self.collectionView.contentOffset.x + offsetX;
                attributes.frame = frame;
            }
            
            [sectionAttributes addObject:attributes];
            
            xOffset = xOffset + MinmumItemWidth;
            column ++;
            
            if (column == _allColumns) {
                if (xOffset > contentWidth) {
                    contentWidth = xOffset;
                }
                
                // 重置基本变量
                column = 0;
                xOffset = 0;
                yOffset += MinmumItemHeight;
            }
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
    
    // 获取右下角最有一个item，确定collectionView的contentSize大小
    UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
    contentHeight = attributes.frame.origin.y + attributes.frame.size.height;
    _contentSize = CGSizeMake(contentWidth, contentHeight);
}

-(CGSize)collectionViewContentSize{
    return  _contentSize;
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewLayoutAttributes *cc = self.itemAttributes[indexPath.section][indexPath.row];
//    NSLog(@"%ld,%ld,%@",(long)indexPath.section,(long)indexPath.row,NSStringFromCGRect(cc.frame));
    return self.itemAttributes[indexPath.section][indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [@[] mutableCopy];
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            CGRect frame = [evaluatedObject frame];
            return CGRectIntersectsRect(rect, frame);
        }]]];
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end
