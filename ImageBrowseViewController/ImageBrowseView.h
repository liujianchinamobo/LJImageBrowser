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

@interface ImageBrowseView : UIView
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, assign) NSInteger index;
@end
