//
//  LJImageBrowseView.m
//  MXY
//
//  Created by liujian on 16/6/29.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "LJImageBrowseView.h"
#import "ImageBrowseItem.h"
#import "LJImageBrowseViewCell.h"

@interface LJImageBrowseView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_imageArray;
}
@end

static NSString *cellIndetifier = @"cell";
@implementation LJImageBrowseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    // 设置显示方式
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    flow.minimumLineSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:frame collectionViewLayout:flow];
    
    [self configration];
    
    return self;
}

-(void)configration
{
    // 配置
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[LJImageBrowseViewCell class] forCellWithReuseIdentifier:cellIndetifier];
    self.dataSource = self;
    self.delegate = self;
    self.pagingEnabled = YES;
}

/**设置数据源*/
-(void)setupImageBrowseWithImageData:(NSArray *)imageArray defaultIndex:(NSInteger)index
{
    if (!imageArray.count) {
        return;
    }
    
    _imageArray = imageArray;
    [self reloadData];
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - UIcollectionviewdatasourece
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJImageBrowseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndetifier forIndexPath:indexPath];
    id obj = _imageArray[indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        cell.imageURL = obj;
    }else if ([obj isKindOfClass:[UIImage class]])
    {
        cell.image = obj;
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.imageDelegate respondsToSelector:@selector(LJImgeBrowseView:imageDidScroll:contentOffset:)]) {
        [self.imageDelegate LJImgeBrowseView:self imageDidScroll:scrollView contentOffset:scrollView.contentOffset];
    }
}
@end

