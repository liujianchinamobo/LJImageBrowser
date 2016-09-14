//
//  LJImageBrowseViewCell.m
//  MXY
//
//  Created by liujian on 16/6/29.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "LJImageBrowseViewCell.h"
#import "LJImageBrowseItem.h"
@interface LJImageBrowseViewCell()
@property (strong,nonatomic) LJImageBrowseItem *item;
@end
@implementation LJImageBrowseViewCell

- (void)awakeFromNib {
}

-(LJImageBrowseItem *)item
{
    if (!_item) {
        _item = [[LJImageBrowseItem alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_item];
    }
    return _item;
}


-(void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
//    [self.item restoreDefaultScale];
    [self.item setZoomScale:1];
    self.item.imageurl = imageURL;
    
}

-(void)setImage:(UIImage *)image
{
    _image = image;
//    [self.item restoreDefaultScale];
    [self.item setZoomScale:1];
    self.item.image = image;
}
@end
