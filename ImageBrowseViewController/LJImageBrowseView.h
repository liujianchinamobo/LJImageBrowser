//
//  LJImageBrowseView.h
//  MXY
//
//  Created by liujian on 16/6/29.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   照片查看器
 
 传入图片数组和对应索引，贴到控制器view上就可以直接使用
 
 注意：适用于图片数组数量较多的时候，利用UICollectionView的复用达到节省内存的目的
 
 */
@class LJImageBrowseView;
@protocol LJImageBrowseViewDelegate <NSObject>
-(void)LJImgeBrowseView:(LJImageBrowseView *)view imageDidScroll:(UIScrollView *)scrollView contentOffset:(CGPoint)offset;
@end

@interface LJImageBrowseView : UICollectionView
/**
 *  传入图片源和当前索引
 *
 *  @param imageArray 图片数组
 *  @param index      当前索引
 */
-(void)setupImageBrowseWithImageData:(NSArray *)imageArray defaultIndex:(NSInteger)index;
/**
 *  图片索引
 */
@property (nonatomic, assign) NSInteger  index;

@property (nonatomic, weak) id  <LJImageBrowseViewDelegate>imageDelegate;


@end

