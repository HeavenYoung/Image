//
//  DownloadImageOperation.h
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageOperation : NSOperation

// 类方法创建下载操作
+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished;
@end
