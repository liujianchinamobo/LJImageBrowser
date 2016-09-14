//
//  ImageBrowseView.m
//  MXY
//
//  Created by liujian on 16/4/7.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "ImageBrowseView.h"
#import "LJImageBrowseItem.h"

@interface ImageBrowseView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITapGestureRecognizer * tap;
@end

@implementation ImageBrowseView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
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

-(void)removeView
{
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
    [self.scrollView setContentOffset:CGPointMake(_index * self.frame.size.width,0)];
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _imageArray.count, self.bounds.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollView;
}

-(void)setupImageBrowseItem
{
    for (int i = 0; i < _imageArray.count; i ++) {
        
        LJImageBrowseItem * item = [[LJImageBrowseItem alloc] initWithFrame:CGRectMake(i*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        
        id obj = _imageArray[i];
        if ([obj isKindOfClass:[NSString class]]) {
            item.imageurl = obj;
        }else if ([obj isKindOfClass:[UIImage class]])
        {
            item.image = obj;
        }
        
        [_scrollView addSubview:item];
    }
}

@end
