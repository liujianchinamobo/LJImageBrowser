//
//  ImageBrowseView.m
//  MXY
//
//  Created by liujian on 16/4/7.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "ImageBrowseView.h"
#import "LJImageBrowseItem.h"

@interface ImageBrowseView()<UIScrollViewDelegate>
{
    /**当前滑到的位置*/
    NSInteger currentIndex;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITapGestureRecognizer * tap;
@property (nonatomic, strong) NSMutableArray * imageBrowseItemArray;
@end

@implementation ImageBrowseView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        [self addtapGesture];
    }
    return self;
}

/**单击*/
-(void)addtapGesture
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:_tap];
}

-(void)showInView:(UIView *)view
{
    if (!view) {
        return;
    }
    
    ImageBrowseItem *item = self.imageBrowseItemArray[_index];
    
    [view addSubview:self];
    
    if (self.frameArray.count) {
        [item showAnimation];
    }
    
}

-(void)removeView
{
    ImageBrowseItem *item = self.imageBrowseItemArray[currentIndex];
    
    if (self.frameArray.count) {
        [UIView animateWithDuration:.3 animations:^{
            self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
            [item removeAnimation];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }else
        [self removeFromSuperview];
    
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    if (!imageArray || !imageArray.count) {
        return;
    }
    
    [self addSubview:self.scrollView];
    [self setupImageBrowseItem];
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    currentIndex = index;
    [self.scrollView setContentOffset:CGPointMake(_index * self.frame.size.width,0)];
}

-(void)setFrameArray:(NSArray *)frameArray
{
    _frameArray = frameArray;
    
    if (self.imageBrowseItemArray.count) {
        for (int i = 0; i < self.imageBrowseItemArray.count; i ++) {
            ImageBrowseItem *item = self.imageBrowseItemArray[i];
            item.origin = [frameArray[i] CGRectValue];
        }
    }
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _imageArray.count, self.bounds.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;

    }
    
    return _scrollView;
}

-(void)setupImageBrowseItem
{
    for (int i = 0; i < _imageArray.count; i ++) {
        
        LJImageBrowseItem * item = [[LJImageBrowseItem alloc] initWithFrame:CGRectMake(i*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        
        for (UIGestureRecognizer *gesture in item.gestureRecognizers) {
            [_tap requireGestureRecognizerToFail:gesture];
        }
        
        id obj = _imageArray[i];
        if ([obj isKindOfClass:[NSString class]]) {
            item.imageurl = obj;
        }else if ([obj isKindOfClass:[UIImage class]])
        {
            item.image = obj;
        }
        
        if (self.frameArray.count) {
            item.origin = [self.frameArray[_index] CGRectValue];
        }
        [_scrollView addSubview:item];
        
        [self.imageBrowseItemArray addObject:item];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentIndex = scrollView.contentOffset.x / scrollView.width;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    currentIndex = scrollView.contentOffset.x / scrollView.width;
}

-(NSMutableArray *)imageBrowseItemArray
{
    if (!_imageBrowseItemArray) {
        _imageBrowseItemArray = [NSMutableArray arrayWithCapacity:_imageArray.count];
    }
    return _imageBrowseItemArray;
}
@end
