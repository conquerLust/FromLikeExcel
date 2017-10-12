//
//  FirstFormViewController.m
//  BaoBiaoDemo
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FirstFormViewController.h"
#import "ItemModel.h"
#import "SecondFormViewController.h"

@interface FirstFormViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation FirstFormViewController

- (void)viewDidLoad {
//    self.formView=self.collectionView;
//    self.formScrollView=self.scrollView;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"第一级报表";
    
    
    //步骤四：为collection赋值
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@1 forKey:@"lockColumn"];
    NSArray *data = @[@[@"",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"M"]
                      ,@[@"1",@"出售",@"-1",@"-1",@"-1",@"-1",@"-1",@"出租",@"-1",@"-1",@"-1",@"-1",@"-1"]
                      ,@[@"2",@"房源数量",@"-1",@"有简易委托",@"-1",@"有普通委托",@"-1",@"房源数量",@"-1",@"有独家委托",@"-1",@"有房勘",@"-1"]
                      ,@[@"3",@"-1",@"-1",@"数量",@"比例",@"数量",@"比例",@"-1",@"-1",@"数量",@"比例",@"数量",@"比例"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      ,@[@"4",@"9",@"-1",@"2",@"4%",@"3",@"%3",@"9",@"-1",@"4",@"%5",@"5",@"%6"]
                      
                      ];
    NSMutableArray *itemsArr=[NSMutableArray arrayWithCapacity:0];
    [data enumerateObjectsUsingBlock:^(NSArray *  _Nonnull arr, NSUInteger section, BOOL * _Nonnull stop) {
        NSMutableArray *sectionItems=[NSMutableArray arrayWithCapacity:0];
        [arr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger column, BOOL * _Nonnull stop) {
            ItemModel *model=[ItemModel new];
            model.title=obj;
            if (section==1) {
                if (column%6==1) {
                    model.crossColumns=6;
                }
            }
            if (section==2) {
                if (column%2==1) {
                    model.crossColumns=2;
                }
            }
            if ([model.title isEqualToString:@"-1"]) {
                model.crossColumns=0;
                model.crossRows=0;
            }
            if ([model.title isEqualToString:@"房源数量"]) {
                model.crossRows=2;
            }
            if ((section>3&&column==1)||(section>3&&column==7)) {
                model.crossColumns=2;
            }
            [sectionItems addObject:model];
        }];
        [itemsArr addObject:sectionItems];
    }];
    [dic setObject:itemsArr forKey:@"data"];
    
    [self updatecollectionView:dic];
   
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SecondFormViewController *secondForm=[storyboard instantiateViewControllerWithIdentifier:@"SecondFormViewController"];
    [self.navigationController pushViewController:secondForm animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
