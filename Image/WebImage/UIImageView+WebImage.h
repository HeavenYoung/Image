//
//  UIImageView+WebImage.h
//  WebImage
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

@property (nonatomic, copy) NSString *URLString;

- (void)setImageWithURLString:(NSString *)URLString;

@end
