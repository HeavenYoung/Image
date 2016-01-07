//
//  DownloadImageOperation.m
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "DownloadImageOperation.h"
#import "NSString+Path.h"

@interface DownloadImageOperation()

@property (nonatomic, copy) NSString *URLString;

// NSOperaton 自身有一个 completionBlock 但是不能穿参数，所以自定义一个Block 
@property (nonatomic, copy) void (^finishedBlock)(UIImage *image);

@end

@implementation DownloadImageOperation

+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finished {

    DownloadImageOperation *op = [[DownloadImageOperation alloc] init];
    op.URLString = URLString;
    op.finishedBlock = finished;
    
    return op;
}

- (void)main {

    @autoreleasepool {
        // 断言
        NSAssert(self.finishedBlock != nil, @"finishedBlock 没有回调内容");

        NSLog(@"正在下载 %@", self.URLString);
        
        // 模仿网络延时
        [NSThread sleepForTimeInterval:1.0];
    
        // URL
        NSURL *url = [NSURL URLWithString:self.URLString];
        
        // 获得二进制数据
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 判断操作是否被取消
        if (self.isCancelled) {
            NSLog(@"%@ 被取消", self.URLString);
            return;
        }
        
        // 将数据保存至沙盒
        if (data != nil) {
            [data writeToFile:self.URLString.appendCachePath atomically:YES];
        }

        // 主线程完成回调
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock([UIImage imageWithData:data]);
        }];
    }
}

@end
