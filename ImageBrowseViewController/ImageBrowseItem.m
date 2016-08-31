
//
//  ImageBrowseItem.m
//  000
//
//  Created by liujian on 16/1/15.
//  Copyright © 2016年 liujian. All rights reserved.
//

#import "ImageBrowseItem.h"
#import "UIImageView+WebCache.h"

#define MAXZOOMSCALE 3
#define MINZOOMSCALE 0.5

@interface ImageBrowseItem()
{
    UIImageView *imageView;
    BOOL isMaxZoomScale;
}
@end

@implementation ImageBrowseItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.maximumZoomScale = MAXZOOMSCALE;
        self.minimumZoomScale = MINZOOMSCALE;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height - self.width)/2, self.width , self.width)];
        imageView.image = DefaultImage;
        [self addSubview:imageView];
        [self addGestureRecognizer];
    }
    return self;
}

-(void)addGestureRecognizer
{
    UITapGestureRecognizer *doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubletap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubletap];
}

-(void)doubleTap:(UITapGestureRecognizer *)tap
{
    if (!isMaxZoomScale) {
        
        [self setZoomScale:2.0 animated:YES];
        isMaxZoomScale = YES;
    }else
    {
        [self setZoomScale:1.0 animated:YES];
        isMaxZoomScale = NO;
    }
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    CGFloat screenW = self.bounds.size.width;
    CGFloat screenH = self.bounds.size.height;

    CGFloat imageW = _image.size.width;
    CGFloat imageH = _image.size.height;
    
    CGFloat scale = imageW / imageH;
    // 默认水平占满屏幕
    imageView.frame = CGRectMake(0, 0, screenW, screenW/scale);
    imageView.image = image;
    
    imageView.center = CGPointMake(screenW/2, screenH/2);
    
}

-(void)setImageurl:(NSString *)imageurl
{
    _imageurl = imageurl;

    CGFloat screenW = self.bounds.size.width;
    CGFloat screenH = self.bounds.size.height;
    
    NSURL *url = nil;
    if ([imageurl hasPrefix:@"http://"] || [imageurl hasPrefix:@"https://"]) {
        url = [NSURL URLWithString:imageurl];
    }else
    {
        url = [NSURL fileURLWithPath:imageurl];
    }
    
    if (url)
    {
        
        [imageView sd_setImageWithURL:url placeholderImage:DefaultImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                CGFloat imageW = image.size.width;
                CGFloat imageH = image.size.height;
                
                CGFloat scale = imageW / imageH;
                
                // 默认水平方向占满屏幕
                [imageView setFrame:CGRectMake(0, 0, screenW, screenW/scale)];
                
                // 竖直方向超出屏幕可以滑动
                self.contentSize = CGSizeMake(screenW, screenW/scale);
                if (screenW/scale < screenH) {
                    imageView.center = CGPointMake(screenW/2, screenH/2);
                }
                
            }else
            {
                NSLog(@"errorimageurl = :%@",imageurl);
                imageView.image = DefaultImage;
                imageView.frame = CGRectMake(0, (screenH - screenW)/2, screenW , screenW);
                
            }

        }];
        
    }
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // 返回要缩放的视图
    return imageView;
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 重置imageView的中心
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                   scrollView.contentSize.height * 0.5 + offsetY );

}

-(void)dealloc
{
    NSLog(@"ImageBrowseItem dealloc");
}

@end