
//
//  ImageBrowseItem.m
//  000
//
//  Created by liujian on 16/1/15.
//  Copyright © 2016年 liujian. All rights reserved.
//

#import "LJImageBrowseItem.h"
#import "UIImageView+WebCache.h"

#define MAXZOOMSCALE 3
#define MINZOOMSCALE 0.5

// 占位图片
#define DefaultImage [UIImage imageNamed:@""]

@interface LJImageBrowseItem()<UIActionSheetDelegate>
{
    UIImageView *imageView;
    BOOL isMaxZoomScale;
}
@end

@implementation LJImageBrowseItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.maximumZoomScale = MAXZOOMSCALE;
        self.minimumZoomScale = MINZOOMSCALE;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height - self.bounds.size.width)/2, self.bounds.size.width , self.bounds.size.width)];
        imageView.image = DefaultImage;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        [self addGestureRecognizer];
    }
    return self;
}

-(void)showAnimation
{
    CGRect frame = imageView.frame;
    imageView.frame = self.origin;
    [UIView animateWithDuration:.3 animations:^{
        imageView.frame = frame;
    }];
}

-(void)removeAnimation
{
    [UIView animateWithDuration:.3 animations:^{
        imageView.frame = self.origin;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
}

-(void)addGestureRecognizer
{
    // 双击放大
    UITapGestureRecognizer *doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubletap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubletap];
    
    // 长按保存到相册
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longpress];
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

-(void)longPress:(UILongPressGestureRecognizer *)press
{
    if (press.state == UIGestureRecognizerStateBegan) {
        
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"分享图片" otherButtonTitles:@"保存图片", nil];
        [action showInView:self];
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            UIImageWriteToSavedPhotosAlbum(imageView.image,  self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            break;
            
        default:
            break;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败，无法访问相册"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已保存到相册"];
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
        
        [imageView sd_setImageWithURL:url placeholderImage:DefaultImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度
            NSLog(@"%ld--%ld",receivedSize,expectedSize);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
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
