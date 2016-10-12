//
//  ImageBrowseView.h
//  MXY
//
//  Created by liujian on 16/4/7.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**照片查看器
 
 用来直接贴到view，适用于非push的情况
 
 */

@class ImageBrowseView;
@class LJImageBrowseItem;

@interface ImageBrowseView : UIView
/**图片数组的位置*/
@property (nonatomic, strong) NSArray * frameArray;
/**图片数组*/
@property (nonatomic, strong) NSArray * imageArray;
/**开始展示的图片位置索引*/
@property (nonatomic, assign) NSInteger index;
/**代理*/
@property (nonatomic, weak) id delegate;
/**展示图片*/
-(void)showInView:(UIView *)view;
@end
