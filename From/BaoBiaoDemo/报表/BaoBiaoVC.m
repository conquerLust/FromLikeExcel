//
//  BaoBiaoVC.m
//  collectionview
//
//  Created by admin on 2017/2/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaoBiaoVC.h"
#import "ItemModel.h"
#import "BaoBiaoLayout.h"
#import "BaoBiaoItem.h"
#import "Masonry.h"

@interface BaoBiaoVC ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *collectionViewData;
@property(nonatomic,strong)BaoBiaoLayout *layout;

@end

@implementation BaoBiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initFormView];
}


-(void)initFormView
{
    
//    if (!self.formScrollView) {
//        self.formScrollView=[[UIScrollView alloc] init];
//        self.formScrollView.delegate=self;
//        self.formScrollView.minimumZoomScale=0.8;
//        self.formScrollView.maximumZoomScale=1.0;
//        self.formScrollView.zoomScale=1.0;
//        [self.view addSubview:self.formScrollView];
//    }
   
    if (!self.formView) {
        self.layout = [[BaoBiaoLayout alloc]init];
        self.formView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [self.formView setDirectionalLockEnabled:YES];
        self.formView.backgroundColor=[UIColor whiteColor];
        self.formView.delegate = self;
        self.formView.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.formView registerNib:[UINib nibWithNibName:@"BaoBiaoItem" bundle:nil] forCellWithReuseIdentifier:@"BaoBiaoItem"];
        
        [self.view addSubview:self.formView];
    }
//     self.formScrollView.contentSize=self.formView.contentSize;
    
//    [self.formScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(64);
//        make.left.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.right.equalTo(self.view);
//    }];
    
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
}


//更新数据
-(void)updatecollectionView:(NSDictionary *)data{
    int lockColumn = [data[@"lockColumn"] intValue];
    if (lockColumn < 0) {
        lockColumn = 0;
    }
    self.collectionViewData = [[NSMutableArray alloc]initWithArray:data[@"data"] copyItems:YES];
    if (self.collectionViewData == nil || self.collectionViewData.count == 0) {
        self.formView.hidden = YES;
        return;
    }
    self.formView.hidden = NO;
//    if(!self.layout){
//        self.layout = [[BaoBiaoLayout alloc]init];
//        self.formView.collectionViewLayout = self.layout;
//    }
    [self.layout reset];
    [self.layout setLockColumn:lockColumn];

    [self.layout setItems:self.collectionViewData];
    [self.formView reloadData];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView==self.formScrollView) {
        return self.formView;
    }
    else{
        return nil;
    }
}

#pragma mark - UICollectionView 的代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.collectionViewData.count;//返回 报表 共有多少行
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.collectionViewData[section];
    return array.count;//返回 报表 每行有多少列
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaoBiaoItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaoBiaoItem" forIndexPath:indexPath];
    
    //设置单元行颜色的间隔的控制
    if (indexPath.section % 2 == 0) {
        [cell setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    }else{
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSArray *array = self.collectionViewData[indexPath.section];
    ItemModel *item=array[indexPath.row];
    
    [cell setMessage:item.title];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
