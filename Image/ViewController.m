//
//  ViewController.m
//  Image
//
//  Created by Heaven on 16/1/6.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.imageView setImageWithURLString:@"http://imgsrc.baidu.com/forum/w%3D580/sign=9b89d1fba4efce1bea2bc8c29f50f3e8/f7374e90f603738da2119e2fb01bb051f819ec1e.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
