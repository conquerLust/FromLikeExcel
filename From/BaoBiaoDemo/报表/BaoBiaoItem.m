//
//  BaoBiaoItem.m
//  admin
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaoBiaoItem.h"
@interface BaoBiaoItem()


@end

@implementation BaoBiaoItem


//设置数据
-(void)setMessage:(NSString *)message{
    self.mLabel.text = [NSString stringWithFormat:@"%@",message];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [super layoutIfNeeded];
    self.frame = CGRectMake(0, 0, 60, 60);
    self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.layer.borderWidth = 0.5f;
}


@end
