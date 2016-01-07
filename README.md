# Image
This library provides a category for UIImageView with support for loading images from the url.
 
- A guarantee that the same URL won't be downloaded 
- A guarantee that main thread will never be blocked
- use NSOperation and ARC

# How To Use
  #import "UIImageView+WebImage.h"
  [self.imageView setImageWithURLString:@"url"]
