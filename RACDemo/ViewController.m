//
//  ViewController.m
//  RACDemo
//
//  Created by 贺凯 on 16/11/15.
//  Copyright © 2016年 贺凯. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HKTableView.h"
#import <AFNetworking/AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
//#import "YTKRequest.h"

@interface ViewController ()
@property (nonatomic, strong)UITextField *textFild;
@property(nonatomic,strong)HKTableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test1];
//    [self test2];
//    [self createButton];
//    [self block];
//    [self ytkNetwork];
//    [self.view addSubview:self.tableView];
    [self textAFPost];
}
-(void)textAFPost{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFHTTPRequestOperation *operation = [manager POST:mutPath
//                                           parameters:param
//                            constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                                
//                                if (mediaDatas.count > 0) {
//                                    NSObject *firstObj = [mediaDatas objectAtIndexSafe:0];
//                                    if ([firstObj isKindOfClass:[UIImage class]]) { //图片
//                                        for(NSInteger i=0; i<mediaDatas.count; i++) {
//                                            UIImage *eachImg = [mediaDatas objectAtIndexSafe:i];
//                                            //NSData *eachImgData = UIImagePNGRepresentation(eachImg);
//                                            NSData *eachImgData = UIImageJPEGRepresentation(eachImg, 0.5);
//                                            [formData appendPartWithFileData:eachImgData name:[NSString stringWithFormat:@"img%d", i+1] fileName:[NSString stringWithFormat:@"img%d.jpg", i+1] mimeType:@"image/jpeg"];
//                                        }
//                                    }else { // 视频
//                                        ALAsset *asset = [mediaDatas objectAtIndexSafe:0];
//                                        NBLog(@"asset=%@, representation=%@, url=%@", asset, [asset defaultRepresentation], [asset defaultRepresentation].url);
//                                        if (asset != nil) {
//                                            NSString *videoPath = [NSDocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.mov", 0]];    // 这里直接强制写一个即可，之前计划是用i++来区分不明视频
//                                            NSURL *url = [NSURL fileURLWithPath:videoPath];
//                                            NSError *theErro = nil;
//                                            BOOL exportResult = [asset exportDataToURL:url error:&theErro];
//                                            NBLog(@"exportResult=%@", exportResult?@"YES":@"NO");
//                                            
//                                            NSData *videoData = [NSData dataWithContentsOfURL:url];
//                                            [formData appendPartWithFileData:videoData name:@"video1" fileName:@"video1.mov" mimeType:@"video/quicktime"];
//                                            NBLog(@"method 2");
//                                        }
//                                    }
//                                }
//                            } success:^(AFHTTPRequestOperation *operation, idresponseObject) {
//                                NSDictionary *returnedDic = [XXBaseViewController parseResponseObj:responseObject];
//                                
//                                NBLog(@"post Big success returnedDic=%@", returnedDic);
//                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                NBLog(@"post big file fail error=%@", error);
//                                if (errorBlock) {
//                                    errorBlock(@{@"errorcode":@(error.code),@"errordomain":error.domain});
//                                }
//                            }];
//    
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long longtotalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"bytesWritten=%d, totalBytesWritten=%lld, totalBytesExpectedToWrite=%lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//        if (xxProgressView != nil) {
//            [xxProgressView setProgressViewTo:totalBytesWritten*1.0/totalBytesExpectedToWrite];
//        }
//    }];
}
-(void)ytkNetwork{
    self.textFild = [[UITextField alloc]init];
    self.textFild.frame = CGRectMake(0, 0, 100, 100);
    self.textFild.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.textFild];
    [[self.textFild rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        NSLog(@"change");
    }];
}
-(void)block{
    NSLog(@"%@",^{
        int temp = 10;
        NSLog(@"%d",temp);
    });
    int temp = 10;
    NSLog(@"%@",^{
        NSLog(@"%d",temp);
    });
    NSLog(@"%@",[^{
        NSLog(@"%d",temp);
    } copy]);
}
-(void)createButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    button.backgroundColor = [UIColor redColor];
    button.center = self.view.center;
//    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x){
        NSLog(@"touchupinside");
    }];
    [self.view addSubview:button];
}
-(void)buttonAction:(UIButton *)sender{
    
    // 创建第二个控制器
    TwoViewController *twoVc = [[TwoViewController alloc] init];
    
    // 设置代理信号
    twoVc.delegateSignal = [RACSubject subject];
    
    // 订阅代理信号
    [twoVc.delegateSignal subscribeNext:^(id x) {
        
        NSLog(@"点击了通知按钮");
    }];
    
    // 跳转到第二个控制器
    [self presentViewController:twoVc animated:YES completion:nil];
}
-(void)test2{
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 3.发送信号
    [subject sendNext:@"1"];
    
    
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}
-(void)test1 {
    // RACSignal使用步骤：
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 - (void)sendNext:(id)value
    
    
    // RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
    
    // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}
-(HKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[HKTableView alloc]init];
        _tableView.frame = self.view.frame;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
