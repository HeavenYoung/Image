//
//  UIImageView+WebImage.m
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <objc/runtime.h>
#import "DownloadImageManager.h"

@implementation UIImageView (WebImage)

- (void)setImageWithURLString:(NSString *)URLString {

    // 判断，如果URL相同，停止下载
    if ([URLString isEqualToString:self.URLString]) {
        [[DownloadImageManager shareManager] cancelDownloadWithURLString:self.URLString];
        
        // 防止cell复用的时候会出问题， 清空一次图像
        self.image = nil;
    }
    
    // 记录要下载的URL -> 当下载完成后，当前的 UIImageView 中会记录显示图片的 URL
    self.URLString = URLString;
    
    __weak typeof(self) weakSelf = self;
    [[DownloadImageManager shareManager] downloadImageOperationWithURLString:self.URLString finished:^(UIImage *image) {
        weakSelf.image = image;
    }];

}

const void *key = "URLString";
- (void)setURLString:(NSString *)URLString {
    objc_setAssociatedObject(self, key, URLString, OBJC_ASSOCIATION_COPY);
}

- (NSString *)URLString {
    return  objc_getAssociatedObject(self, key);
}

@end
