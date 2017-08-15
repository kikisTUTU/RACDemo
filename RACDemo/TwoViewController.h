//
//  TwoViewController.h
//  RACDemo
//
//  Created by 贺凯 on 16/11/16.
//  Copyright © 2016年 贺凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TwoViewController : UIViewController
@property (nonatomic, strong) RACSubject *delegateSignal;
@end
