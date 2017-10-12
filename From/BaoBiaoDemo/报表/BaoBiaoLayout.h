//
//  BaoBiaoLayout.h
//  collectionview
//
//  Created by admin on 2017/2/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoBiaoLayout : UICollectionViewLayout

//设置锁定列数量
-(void)setLockColumn:(NSInteger)lockColumn;

//重置每一个item的大小和布局
-(void)reset;

-(void)setItems:(NSArray *)itemsArr;

@end
