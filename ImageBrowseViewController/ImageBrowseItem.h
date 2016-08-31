//
//  ImageBrowseItem.h
//  000
//
//  Created by liujian on 16/1/15.
//  Copyright © 2016年 liujian. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  图片放大器
 */
@interface ImageBrowseItem : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * imageurl;
@end
