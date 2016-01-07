//
//  NSString+Path.h
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

///  追加文档目录
- (NSString *)appendDocumentPath;
///  追加缓存目录
- (NSString *)appendCachePath;
///  追加临时目录
- (NSString *)appendTempPath;

@end
