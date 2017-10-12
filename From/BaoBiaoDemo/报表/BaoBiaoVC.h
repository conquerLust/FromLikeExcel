//
//  BaoBiaoVC.h
//  collectionview
//
//  Created by admin on 2017/2/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaoBiaoVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *formView;
@property (strong, nonatomic) UIScrollView *formScrollView;
//更新数据
-(void)updatecollectionView:(NSDictionary *)data;

@end
