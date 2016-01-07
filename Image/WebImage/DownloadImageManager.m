//
//  DownloadImageManager.m
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "DownloadImageManager.h"
#import "DownloadImageOperation.h"
#import "NSString+Path.h"

@interface DownloadImageManager()

///  队列
@property (nonatomic, strong) NSOperationQueue *downloadQueue;
///  操作缓冲池
@property (nonatomic, strong) NSMutableDictionary *operationChache;

@end

@implementation DownloadImageManager

+ (instancetype)shareManager {
    static DownloadImageManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    // 注销通知
    // 提问：会执行到吗？不会执行到，但是，写了也没影响！
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clearMemory {
    // 1. 取消所有下载操作
    [self.downloadQueue cancelAllOperations];
    
    // 2. 清理缓冲池
    [self.operationChache removeAllObjects];
}

- (void)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finished {

    // 断言
    NSAssert(finished != nil, @"需要传入finished");
    
    // 1. 判断是否有相同的操作
    if (self.operationChache[URLString]) {
        NSLog(@"正在下载，请耐心等待");
    }
    
    // 2. 检查缓存
    // 如果有缓存，直接返回缓存的图像
    if ([self checkImageCache:URLString]) {
        
        // 回调
        finished([self.imageCache objectForKey:URLString]);
        
        return;
    }

    // 3. 实例化下载操作
    DownloadImageOperation *op = [DownloadImageOperation downloadImageOperationWithURLString:URLString finished:^(UIImage *image) {
        
        // 完成回调
        finished(image);
        
        // 从缓冲池删除操作
        [self.operationChache removeObjectForKey:URLString];
    }];
    
    // 添加到缓冲池
    [self.operationChache setObject:op forKey:URLString];
    
    // 添加到队列 － 开始下载
    [self.downloadQueue addOperation:op];
}

- (void)cancelDownloadWithURLString:(NSString *)URLString {
    
    // 1. 从操作缓冲池中获取到下载操作
    DownloadImageOperation *op = self.operationChache[URLString];
    
    if (op == nil) {
        return;
    }
    
    // 2. 给操作发送 cancel 消息，取消操作
    [op cancel];
    NSLog(@"取消下载 ---> %@", URLString);
    
    // 3. 从缓冲池中删除下载操作
    [self.operationChache removeObjectForKey:URLString];
}

- (BOOL)checkImageCache:(NSString *)URLString {
    // 1. 检查内存缓存，如果有返回YES
    if ([self.imageCache objectForKey:URLString]) {
        NSLog(@"内存缓存");
        return YES;
    }
    
    // 2. 检查沙盒缓存，如果有，设置内存缓存，返回YES
    UIImage *image = [UIImage imageWithContentsOfFile:URLString.appendCachePath];
    if (image) {
        [self.imageCache setObject:image forKey:URLString];
        NSLog(@"沙盒缓存");
        return YES;
    }
    return NO;
}

#pragma mark - 懒加载
- (NSCache *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc] init];
    }
    // 设定上限
    _imageCache.countLimit = 15;
    return _imageCache;
}

- (NSMutableDictionary *)operationChache {
    if (_operationChache == nil) {
        _operationChache = [NSMutableDictionary dictionary];
    }
    return _operationChache;
}

- (NSOperationQueue *)downloadQueue {
    if (_downloadQueue == nil) {
        _downloadQueue = [[NSOperationQueue alloc] init];
    }
    return _downloadQueue;
}

@end
