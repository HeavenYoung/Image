//
//  DownloadImageManager.h
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageManager : NSObject

///  图像缓冲池
@property (nonatomic, strong) NSCache *imageCache;

+ (instancetype)shareManager;

// 下载操作 借用自定义操作
- (void)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished;

//  取消指定 URLString 对应的下载操作
- (void)cancelDownloadWithURLString:(NSString *)URLString;

@end
