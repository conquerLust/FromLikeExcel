//
//  ItemModel.h
//  BaoBiaoDemo
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property(nonatomic,assign)NSUInteger crossColumns;  //跨列数
@property(nonatomic,assign)NSUInteger crossRows;  //跨列数
@property(nonatomic,copy)NSString *title;

@end
