//
//  LJImageBrowseViewCell.h
//  MXY
//
//  Created by liujian on 16/6/29.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**图片查看器cell*/

@interface LJImageBrowseViewCell : UICollectionViewCell
/**当前图片链接*/
@property (nonatomic, strong) NSString * imageURL;
/**当前图片*/
@property (nonatomic, strong) UIImage * image;
@end
