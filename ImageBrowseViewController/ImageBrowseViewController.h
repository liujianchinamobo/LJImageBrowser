//
//  ImageBrowseViewController.h
//  000
//
//  Created by liujian on 16/1/15.
//  Copyright © 2016年 liujian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *图片查看器 传入图片数组和图片索引即可
 适用于push或者非全屏的情况
 
 */
@interface ImageBrowseViewController : UIViewController
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, assign) NSInteger  index;
@end
