


//
//  ImageBrowseViewController.m
//  000
//
//  Created by liujian on 16/1/15.
//  Copyright © 2016年 liujian. All rights reserved.
//

#import "ImageBrowseViewController.h"
#import "LJImageBrowseItem.h"

@interface ImageBrowseViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIScrollView * currentScrollView;
@end

@implementation ImageBrowseViewController

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    if (!imageArray || !imageArray.count) {
        return;
    }
    
    [self.view addSubview:self.scrollView];
    [self setupImageBrowseItem];
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    [self.scrollView setContentOffset:CGPointMake(_index * self.view.frame.size.width,0)];
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _imageArray.count, self.view.bounds.size.height);
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
        UIImage *image = _imageArray[i];
        item.image = image;
        [_scrollView addSubview:item];
    }
}

@end
