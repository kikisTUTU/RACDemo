//
//  HKTableView.m
//  RACDemo
//
//  Created by 贺凯 on 16/12/8.
//  Copyright © 2016年 贺凯. All rights reserved.
//

#import "HKTableView.h"

@implementation HKTableView


- (id)initWithFrame:(CGRect)frame dataSource:(id)dataSource delegate:(id)delegate style:(UITableViewStyle )style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource             =   dataSource;
        self.delegate               =   delegate;
        self.separatorColor         =   [UIColor colorWithRed:197.0/255.0 green:197/255.0 blue:197/255.0 alpha:1];
        self.tableFooterView        =   [[UIView alloc] init];
        self.backgroundColor        =   [UIColor redColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator   = NO;
        if (style==UITableViewStyleGrouped) {
            self.backgroundView=nil;
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
